using BuyHereApp.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using BuyHere.Models;
using BuyHere;

namespace BuyHereApp.Controllers
{
    public class HomeController : Controller
    {
        private readonly BuyHereContext _context;
        BuyHereRepo repObj;

        public HomeController(BuyHereContext context)
        {
            _context = context;
            repObj = new BuyHereRepo(_context);
        }

        public IActionResult Index()
        {
            return View();
        }

        public IActionResult Privacy()
        {
            return View();
        }
        public IActionResult Login()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
        public IActionResult CheckRole(IFormCollection frm)
        {
            string userId = frm["name"];
            string password = frm["pwd"];
            byte? roleId = repObj.ValidateCredentials(userId, password);


            if (roleId == 1)
            {
                return RedirectToAction("AdminHome", "Admin");
            }
            else if (roleId == 2)
            {
                return RedirectToAction("CustomerHome", "Customer");
            }
            return View("Login");
        }

    }
}
