using Microsoft.AspNetCore.Mvc;
using System;
using System.Linq;
using System.Threading.Tasks;
using System.Collections.Generic;
namespace BuyHereApp.Controllers
{
    public class AdminController : Controller
    {
        public IActionResult AdminHome()
        {
            return View();
        }
    }
}
