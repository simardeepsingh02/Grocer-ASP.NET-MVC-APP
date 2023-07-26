using AutoMapper;
using BuyHere;
using BuyHere.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;

namespace BuyHereApp.Controllers
{
    public class ProductController : Controller
    {
        private readonly IMapper _mapper;
        private readonly BuyHereContext _context;
        BuyHereRepo repObj;
        public ProductController(BuyHereContext context, IMapper mapper)
        {
            _context = context;
            repObj = new BuyHereRepo(_context);
            _mapper = mapper;
        }

        public IActionResult ViewProducts()
        {
            var lstEntityProducts = repObj.GetProducts();
            List<Models.Products> lstModelProducts = new List<Models.Products>();
            foreach (var product in lstEntityProducts)
            {
                lstModelProducts.Add(_mapper.Map<Models.Products>(product));
            }
            return View(lstModelProducts);
        }
        public IActionResult AddProduct()
        {
            string productId = repObj.GetNextProductId();
            ViewBag.NextProductId = productId;
            return View();
        }
        [HttpPost]
        public IActionResult SaveAddedProduct(Models.Products product)
        {
            bool status = false;
            if (ModelState.IsValid)
            {
                try
                {
                    status = repObj.AddProduct(_mapper.Map<Products>(product));
                    if (status)
                        return RedirectToAction("ViewProducts");
                    else
                        return View("Error");
                }
                catch (Exception)
                {
                    return View("Error");
                }
            }
            return View("AddProduct", product);
        }

        public IActionResult UpdateProduct(Models.Products prodObj)
        {
            return View(prodObj);
        }
        [HttpPost]
        public IActionResult SaveUpdatedProduct(Models.Products product)
        {
            bool status = false;
            if (ModelState.IsValid)
            {
                try
                {
                    status = repObj.UpdateProduct(_mapper.Map<Products>(product));
                    if (status)
                        return RedirectToAction("ViewProducts");
                    else
                        return View("Error");
                }
                catch (Exception)
                {
                    return View("Error");
                }
            }
            return View("UpdateProduct", product);
        }
       
        public IActionResult DeleteProduct(Models.Products product)
        {
            return View(product);
        }
        
        public IActionResult SaveDeletion(string productId)
        {
            bool status = false;
            try
            {
                status = repObj.DeleteProduct(productId);
                if (status)
                    return RedirectToAction("ViewProducts");
                else
                    return View("Error");
            }
            catch (Exception)
            {
                return View("Error");
            }
        }


    }
}
