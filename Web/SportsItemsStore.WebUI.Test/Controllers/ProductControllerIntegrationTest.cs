using System.Linq;
using System.Web.Mvc;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using MvcIntegrationTestFramework.Browsing;
using MvcIntegrationTestFramework.Hosting;
using System;
using SportsItemsStore.Domain.Entities;

namespace SportsItemsStore.WebUI.Test.Controllers
{
    [TestClass]
    public class ProductControllerIntegrationTest
    {
        private AppHost _appHost;

        [TestInitialize]
        public void TestFixtureSetUp()
        {
            //If you MVC project is not in the root of your solution directory then include the path
            //e.g. AppHost.Simulate("Website\SportsItemsStore.WebUI")
            _appHost = AppHost.Simulate("SportsItemsStore.WebUI");
        }

        [TestMethod]
        public void Root_Url_Renders_List_View()
        {
            _appHost.Start(browsingSession =>
            {
                // Request the root URL
                RequestResult result = browsingSession.Get("");

                // Can make assertions about the ActionResult...
                var viewResult = (ViewResult)result.ActionExecutedContext.Result;

                Assert.AreEqual("List", viewResult.ViewName);

                // ... or can make assertions about the rendered HTML
                Assert.IsTrue(result.ResponseText.Contains("<!DOCTYPE html"));
            });
        }

        [TestMethod]
        public void DisplayProduct_AddToCart_Test()
        {
            _appHost.Start(browsingSession =>
            {
                // Request the root URL
                RequestResult result = browsingSession.Get("");

                // Can make assertions about the ActionResult...
                var viewResult = (ViewResult)result.ActionExecutedContext.Result;
                Assert.AreEqual("List", viewResult.ViewName);

                const string url = "cart/AddtoCart";

                var addToCartResult = browsingSession.Post(url, new
                {
                    productId = "1",
                    returnUrl = "secret",
                    sizeId = "1",
                    colorId = "1",
                    mnfcId = "1"
                });

                Console.WriteLine(browsingSession.Session["SizeId"]);
                Console.WriteLine(browsingSession.Session["ColorId"]);
                Console.WriteLine(browsingSession.Session["Cart"]);

                Assert.IsTrue(addToCartResult.Response.RedirectLocation.Contains("/cart/Index"), "Didn't redirect to Cart Index");

                var cartResult = browsingSession.Get(addToCartResult.Response.RedirectLocation);

                var count = ((Models.CartIndexViewModel)
                   (((ViewResultBase)(cartResult.ActionExecutedContext.Result)).Model)).Cart.Lines.Count();

                Assert.IsTrue(count > 0);
            });
        }

        [TestMethod]
        public void LogIn_DisplayProduct_AddToCart_Test()
        {
            const string loginActionUrl = "/account/login";

            _appHost.Start(browsingSession =>
            {
                #region Post the login form
                RequestResult loginResult = browsingSession.Post(loginActionUrl, new
                {
                    UserName = "TestUser1",
                    Password = "test@123"
                });

                var action = (RedirectToRouteResult)(loginResult.ResultExecutedContext.Result);

                Assert.AreEqual("List", action.RouteValues["action"]);
                Assert.AreEqual("Product", action.RouteValues["controller"]);
                #endregion

                #region Show Product List
                const string productListUrl = "Product/List";

                // Check that we can now follow the redirection back to the protected action, and are let in
                RequestResult productListResult = browsingSession.Get(productListUrl);

                var cart = (Cart)((ViewResultBase)(productListResult.ResultExecutedContext.Result)).Model;

                Assert.IsTrue(!cart.Lines.Any(), "Cart is blank.");
                #endregion

                #region Add to Cart

                const string url = "cart/AddtoCart";

                var addToCartResult = browsingSession.Post(url, new
                {
                    productId = "1",
                    returnUrl = "secret",
                    sizeId = "1",
                    colorId = "1",
                    mnfcId = "1"
                });

                Assert.IsTrue(addToCartResult.Response.RedirectLocation.Contains("/cart/Index"), "Didn't redirect to Cart Index");

                var cartResult = browsingSession.Get(addToCartResult.Response.RedirectLocation);

                var count = ((Models.CartIndexViewModel)
                   (((ViewResultBase)(cartResult.ActionExecutedContext.Result)).Model)).Cart.Lines.Count();

                Assert.IsTrue(count > 0);
                #endregion
            });
        }
    }
}
