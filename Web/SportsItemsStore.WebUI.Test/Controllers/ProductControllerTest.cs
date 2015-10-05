using System.Linq;
using System.Web.Mvc;
using Microsoft.VisualStudio.TestTools.UnitTesting;
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
    }
}
