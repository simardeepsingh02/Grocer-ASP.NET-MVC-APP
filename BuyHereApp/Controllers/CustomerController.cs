using Microsoft.AspNetCore.Mvc;
using System;
using System.Linq;
using System.Threading.Tasks;
using System.Collections.Generic;
namespace BuyHereApp.Controllers
{
    public class CustomerController : Controller
    {
        public IActionResult CustomerHome()
        {
            List<string> lstProducts = new List<string>();
            lstProducts.Add("Dell Inspiron");
            lstProducts.Add("Marble chess board");
            lstProducts.Add("Adidas shoes");
            ViewBag.TopProducts = lstProducts;
            return View();
        }


    }
}
