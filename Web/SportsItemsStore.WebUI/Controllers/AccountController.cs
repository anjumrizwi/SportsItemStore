using System.Linq;
using System.Web.Mvc;
using SportsItemsStore.Domain.Abstract;
using SportsItemsStore.Domain.Entities;
using SportsItemsStore.WebUI.Models;
using System.Web.Security;

namespace SportsItemsStore.WebUI.Controllers
{
    public class AccountController : Controller
    {
        private readonly IProductsRepository _repository;

        public AccountController(IProductsRepository repo)
        {
            _repository = repo;
        }

        public ActionResult Index()
        {
            return View();
        }

        public ViewResult Login(string returnUrl)
        {
            var model = new LoginViewModel {Username = string.Empty, Password = string.Empty, returnUrl = returnUrl};
            Session["User"] = null;

            return View(model);
        }

        [HttpPost]
        public ActionResult Login(LoginViewModel model,string returnUrl)
        {
            if (ModelState.IsValid)
            {
                var user = _repository.Users.FirstOrDefault(item => item.Username.ToLower() == model.Username.ToLower() && item.Password == model.Password);

                if (user == null || user.Password != model.Password)
                {
                    ModelState.AddModelError("","The Username or password id correct");
                    return View(model);
                }

                FormsAuthentication.SetAuthCookie(model.Username, false);

                Session["User"] = user;

                if (!string.IsNullOrEmpty(returnUrl) && returnUrl !="/Product/ViewDetails")
                {
                    return Redirect(returnUrl);
                }

                return RedirectToAction("List", "Product");
            }
            return View(model);
        }

        [Authorize]
        public ActionResult LogOff()
        {
            FormsAuthentication.SignOut();
   
            Session["User"] = null;

            return RedirectToAction("List", "Product");
        }

        public ActionResult Register(string returnUrl)
        {
            var registerUser = new UserRegistrationModel();

            return View(registerUser);
        }

        [HttpPost]
        public ViewResult Register(UserRegistrationModel model,string returnUrl)
        {
            if (ModelState.IsValid)
            {
                var existUser = _repository.Users.FirstOrDefault(item => item.Username.ToLower() == model.Username.ToLower());
                if (existUser == null)
                {
                    var user = new User {Username = model.Username, Password = model.Password, Email = model.Email};

                    _repository.SaveUser(user);

                    ViewBag.returnUrl = returnUrl;
                    return View("RegistrationCompleted");
                }

                ModelState.AddModelError("", "An User with same User name already exists");
                
                return View(model);
            }
            //
            // If we got this far, something failed, redisplay form!
            //
            return View(model);
        }
    }
}
