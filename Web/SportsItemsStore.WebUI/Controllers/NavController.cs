using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web.Mvc;
using SportsItemsStore.Domain.Abstract;
using SportsItemsStore.Domain.Entities;

namespace SportsItemsStore.WebUI.Controllers
{
    public class NavController : Controller
    {
        private readonly IProductsRepository _repository;

        public NavController(IProductsRepository repo)
        {
            _repository = repo;
        }

        public PartialViewResult Menu(string category = null)
        {
            ViewBag.SelectedCategory = category;

            IEnumerable<Category> categories = _repository.Categories;

            var sizes = _repository.Sizes.Select(x => new SelectListItem { Text = x.ShortName, Value = x.SizeID.ToString() }).ToList();
            sizes.Insert(0, new SelectListItem { Text = "--Select--", Value = "0" });

            ViewData["Sizes"] = sizes;

            var colors = _repository.Colors.Select(x => new SelectListItem { Text = x.Name, Value = x.ColorID.ToString() }).ToList();
            colors.Insert(0, new SelectListItem { Text = "--Select--", Value = "0" });

            ViewData["Colors"] = colors;

            return PartialView(categories);
        }

        [ChildActionOnly]
        public void ClearSessionValues()
        {
            Session["SizeId"] = null;
            Session["ColorId"] = null;
        }
    }
}
