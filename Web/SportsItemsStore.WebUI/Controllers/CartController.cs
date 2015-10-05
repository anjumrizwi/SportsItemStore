using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using SportsItemsStore.Domain.Abstract;
using SportsItemsStore.Domain.Entities;
using SportsItemsStore.WebUI.Models;

namespace SportsItemsStore.WebUI.Controllers
{
    public class CartController : Controller
    {
        private readonly IProductsRepository _repository;

        public CartController(IProductsRepository repo)
        {
            _repository = repo;
        }

        public ViewResult Index(Cart cart, string returnUrl)
        {
            return View(new CartIndexViewModel
            {
                Cart = cart,
                ReturnUrl = returnUrl
            });
        }

        public RedirectToRouteResult AddToCart(Cart cart, int productId, string returnUrl, string sizeId, string colorId, string mnfcId)
        {
            var product = _repository.Products.FirstOrDefault(p => p.ProductID == productId);

            var szId = Convert.ToInt32(sizeId == "" ? "0" : sizeId);
            var clrId = Convert.ToInt32(colorId == "" ? "0" : colorId);
            var mnId = Convert.ToInt32(mnfcId == "" ? "0" : mnfcId);

            var size = _repository.Sizes.Where(x => x.SizeID == szId).Select(y => y.ShortName).SingleOrDefault();
            var color = _repository.Colors.Where(x => x.ColorID == clrId).Select(y => y.Name).SingleOrDefault();
            var mnfc = _repository.Manufacturers.Where(x => x.ManufacturerID == mnId).Select(y => y.Name).SingleOrDefault();

            if (product != null)
            {
                cart.AddItem(product, 1, size, color, mnfc, szId, clrId, mnId, "", DateTime.Now);
            }

            returnUrl = Url.Action("List", "Product");

            return RedirectToAction("Index", new { returnUrl });
        }

        public RedirectToRouteResult RemoveFromCart(Cart cart, int productId, string returnUrl, int sizeId, int colorId, int mnfcId)
        {
            var product = _repository.Products.FirstOrDefault(p => p.ProductID == productId);

            if (product != null)
            {
                cart.RemoveLine(product, sizeId, colorId, mnfcId);
            }
            return RedirectToAction("Index", new { returnUrl });
        }

        [ChildActionOnly]
        public PartialViewResult Summary(Cart cart)
        {
            var userId = 0;

            if (Session["User"] != null)
            {
                var user = (User)Session["User"];
                userId = user.ID;
            }

            if (userId > 0)
            {
                if (_repository.Orders.Any(o => o.UserId == userId))
                {
                    ViewBag.UserId = userId;
                }
            }

            return PartialView(cart);
        }

        public ViewResult MyOrder(string returnUrl, int userId)
        {
            IList<Order> orders = _repository.Orders.Where(o => o.UserId == userId).OrderByDescending(x => x.OrderId).Take(20).ToList();
            return View(orders);
        }

        [HttpPost]
        public PartialViewResult MyOrderDetails(int orderId)
        {
            try
            {
                var orderDetails = _repository.OrderDetails.Where(o => o.Order.OrderId == orderId).ToList();
                return PartialView("MyOrderDetails", orderDetails);
            }
            catch (Exception)
            {
                return null;
            }
        }

        [ChildActionOnly]
        public void ClearCart(Cart cart)
        {
            if (cart != null)
            {
                cart.Clear();
            }
        }

        [Authorize]
        public ViewResult Checkout()
        {
            return View(new ShippingDetails());
        }

        [HttpPost]
        public ViewResult Checkout(Cart cart, ShippingDetails shippingDetails)
        {
            if (!cart.Lines.Any())
            {
                ModelState.AddModelError("", "Sorry, your cart is empty!");
            }

            if (ModelState.IsValid)
            {
                var addrs = new Address
                {
                    Name = shippingDetails.Name,
                    Line1 = shippingDetails.Line1,
                    Line2 = shippingDetails.Line2,
                    Line3 = shippingDetails.Line3,
                    City = shippingDetails.City,
                    State = shippingDetails.State,
                    Zip = shippingDetails.Zip,
                    Country = shippingDetails.Country,
                    UserId = shippingDetails.UserId
                };

                _repository.SaveAddress(addrs);

                if (addrs.AddressID > 0)
                {

                    var order = new Order
                    {
                        AddressId = addrs.AddressID,
                        UserId = shippingDetails.UserId,
                        OrderDate = DateTime.Now
                    };

                    var orderDetails = new List<OrderDetail>();

                    foreach (var line in cart.Lines)
                    {
                        var orderDetail = new OrderDetail
                        {
                            ProductId = line.Product.ProductID,
                            Quantity = line.Quantity,
                            SizeId = line.SizeId,
                            ColorId = line.ColorId,
                            ManufacturerId = line.ManufactererId,
                            SubTotal = (line.Product.Price * line.Quantity)
                        };

                        order.OrderTotal += orderDetail.SubTotal;

                        orderDetails.Add(orderDetail);
                    }

                    order.OrderDetails = orderDetails;

                    _repository.SaveOrder(order);
                }

                return View("Completed", new ShippingViewModel
                {
                    crt = cart,
                    shipDtls = shippingDetails
                });
            }

            return View(shippingDetails);
        }
    }
}
