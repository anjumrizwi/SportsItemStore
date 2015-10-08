using System;
using System.IO;
using System.Linq;
using System.Security.Principal;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using NSubstitute;
using SportsItemsStore.Domain.Abstract;
using SportsItemsStore.Domain.Concrete;
using SportsItemsStore.WebUI.Controllers;
using SportsItemsStore.WebUI.Models;

namespace SportsItemsStore.WebUI.Test.Controllers
{
    [TestClass]
    public class ProductControllerTest
    {
        private IProductsRepository _repository;
        public int PageSize = 4;

        [TestInitialize]
        public void Initialize()
        {
            _repository = new EFProductRepository();

            //HttpContext.Current = new HttpContext(new HttpRequest("", "http://tempuri.org", ""), new HttpResponse(new StringWriter()));

            //// User is logged in
            //HttpContext.Current.User = new GenericPrincipal(new GenericIdentity("username"), new string[0]);

            //// User is logged out
            //HttpContext.Current.User = new GenericPrincipal(new GenericIdentity(String.Empty), new string[0]);
        }

        [TestMethod]
        public void ListTest()
        {
            var controller = new ProductController(_repository);

            var result = (ViewResult)controller.List();

            var obj = result.Model as ProductsListViewModel;

            Assert.IsNotNull(obj);

            // Assert
            Assert.AreEqual(5, obj.Products.Count());
        }

        /// <summary>
        /// TODO: Fix nullReference issue
        /// </summary>
        [TestMethod]
        public void InfinateScrollTest()
        {
            var contextMock = Substitute.For<HttpContextBase>();

            var controller = new ProductController(_repository);

            var routeData = new RouteData();
            routeData.Values.Add("controller", "Product");
            routeData.Values.Add("action", "InfinateScroll");

            var context = new ControllerContext(contextMock, routeData, controller);

            controller.ControllerContext = context;

            var result = (ViewResult)controller.InfinateScroll();

            var obj = result.Model as ProductsListViewModel;

            Assert.IsNotNull(obj);

            // Assert
            Assert.AreEqual(5, obj.Products.Count());
        }
    }
}
