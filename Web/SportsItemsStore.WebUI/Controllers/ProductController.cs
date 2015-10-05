using System.Globalization;
using System.Linq;
using System.Web.Mvc;
using SportsItemsStore.Domain.Entities;
using SportsItemsStore.Domain.Abstract;
using SportsItemsStore.WebUI.Models;
using System.IO;

namespace SportsItemsStore.WebUI.Controllers
{
    public class ProductController : Controller
    {
        private readonly IProductsRepository _repository;
        readonly ItemLoaderManager _iLoaderMgr;
        public int PageSize = 4;

        public ProductController(IProductsRepository productRepository)
        {
            _repository = productRepository;
            _iLoaderMgr = new ItemLoaderManager(productRepository);
        }

        public ActionResult List(int categoryId = 0, int blockNumber = 1, int blockSize = 5, string searchTerm = null,
            int sizeId = 0, int colorId = 0, int start = 0, int end = 0)
        {
            var model = _iLoaderMgr.ProductsList(categoryId, blockNumber, blockSize, searchTerm, sizeId, colorId, start, end);

            return View(model);
        }

        [HttpPost]
        public ActionResult InfinateScroll(int categoryId = 0, int blockNumber = 1, int blockSize = 5, string searchTerm = null,
            int sizeId = 0, int colorId = 0, int start = 0, int end = 0)
        {
            //////////////// THis line of code only for demo. Needs to be removed ///////////////
            System.Threading.Thread.Sleep(3000);
            ////////////////////////////////////////////////////////////////////////////////////////

            var productModel = _iLoaderMgr.ProductsList(categoryId, blockNumber, blockSize, searchTerm, sizeId, colorId, start, end);

            var jsonModel = new JsonModel
                {
                    NoMoreData = productModel.Products.Count() < blockSize,
                    HTMLString = RenderPartialViewToString("ProductPopList", productModel)
                };

            return Json(jsonModel);
        }

        protected string RenderPartialViewToString(string viewName, object model)
        {
            if (string.IsNullOrEmpty(viewName))
                viewName = ControllerContext.RouteData.GetRequiredString("action");

            ViewData.Model = model;

            using (var sw = new StringWriter())
            {
                var viewResult = ViewEngines.Engines.FindPartialView(ControllerContext, viewName);
                var viewContext = new ViewContext(ControllerContext, viewResult.View, ViewData, TempData, sw);
                viewResult.View.Render(viewContext, sw);

                return sw.GetStringBuilder().ToString();
            }
        }

        public JsonResult GetProducts(string term)
        {
            var prods = _repository.Products.Where(p => p.Name.Contains(term)).Select(y => y.Name).ToList();

            return Json(prods, JsonRequestBehavior.AllowGet);
        }


        public ViewResult ViewDetails(int productId, string returnUrl)
        {
            Product prod = null;

            if (productId != 0)
            {
                prod = _repository.Products.SingleOrDefault(p => p.ProductID == productId);
            }

            if (prod != null)
            {
                ViewData["Sizes"] = prod.ProductSizes.Select(x => new SelectListItem { Text = x.Size.ShortName, Value = x.Size.SizeID.ToString(CultureInfo.InvariantCulture) }).ToList();

                ViewData["Colors"] = prod.ProductColors.Select(y => new SelectListItem { Text = y.Color.Name, Value = y.Color.ColorID.ToString(CultureInfo.InvariantCulture) }).ToList();

                ViewData["Manufacterers"] = prod.ProductManufacturers.Select(z => new SelectListItem { Text = z.Manufacturer.Name, Value = z.Manufacturer.ManufacturerID.ToString(CultureInfo.InvariantCulture) }).ToList();

            }

            var model = new DetailsViewModel
            {
                product = prod,
                ReturnUrl = returnUrl
            };

            return View(model);
        }

        public PartialViewResult SearchWithFilters(int categoryId = 0, int blockNumber = 1, int blockSize = 5, string searchTerm = null,
           int sizeId = 0, int colorId = 0, int start = 0, int end = 0)
        {

            ViewBag.SizeId = sizeId;
            ViewBag.ColorId = colorId;
            ViewBag.Start = start;
            ViewBag.End = end;

            var model = _iLoaderMgr.ProductsList(categoryId, blockNumber, blockSize, searchTerm, sizeId, colorId, start, end);

            return PartialView("ProductsList", model);

        }

        public PartialViewResult GetallView(int categoryId = 0, int blockNumber = 1, int blockSize = 5, string searchTerm = null,
           int sizeId = 0, int colorId = 0, int start = 0, int end = 0)
        {

            ViewBag.SizeId = sizeId;
            ViewBag.ColorId = colorId;
            ViewBag.Start = start;
            ViewBag.End = end;

            var model = _iLoaderMgr.ProductsList(categoryId, blockNumber, blockSize, searchTerm, sizeId, colorId, start, end);

            return PartialView("ProductsList", model);
        }

        public PartialViewResult GetallByPriceRange(int categoryId = 0, int blockNumber = 1, int blockSize = 5, string searchTerm = null,
           int sizeId = 0, int colorId = 0, int start = 0, int end = 0)
        {

            ViewBag.SizeId = sizeId;
            ViewBag.ColorId = colorId;
            ViewBag.Start = start;
            ViewBag.End = end;

            var model = _iLoaderMgr.ProductsList(categoryId, blockNumber, blockSize, searchTerm, sizeId, colorId, start, end);

            return PartialView("ProductsList", model);
        }
    }
}
