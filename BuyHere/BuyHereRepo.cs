using BuyHere.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BuyHere
{
    public class BuyHereRepo
    {
        private readonly BuyHereContext _context;

        public BuyHereRepo(BuyHereContext context)
        {
            _context = context;
        }

        public List<Models.Categories> GetCategories()
        {
            try
            {
                return _context.Categories.ToList();
            }
            catch (Exception e)
            {
                return null;
            }
        }

        public bool AddCategory(Categories catObj)
        {
            try
            {
                _context.Categories.Add(catObj);
                _context.SaveChanges();
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public bool UpdateCategory(Categories catObj)
        {
            try
            {
                var catObjFromDB = _context.Categories.Where(x => x.CategoryId == catObj.CategoryId).Select(x => x).FirstOrDefault();
                catObjFromDB.CategoryName = catObj.CategoryName;
                _context.SaveChanges();
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public bool DeleteCategory(Categories catObj)
        {
            try
            {
                var categoryToBeDeleted = _context.Categories.Where(x => x.CategoryId == catObj.CategoryId).FirstOrDefault();
                _context.Categories.Remove(categoryToBeDeleted);
                _context.SaveChanges();
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        public byte? GetRoleIdByUserId(string userId)
        {
            try
            {
                var roleId = _context.Users.Where(x => x.EmailId == userId).Select(x => x.RoleId).FirstOrDefault();
                //var roleName = context.Roles.Where(x => x.RoleId == roleId).Select(x => x.RoleName).FirstOrDefault();
                return roleId;
            }
            catch (Exception)
            {
                return null;
            }
        }
        public string GetRoleName(int roleId)
        {
            try
            {
                var roleName = _context.Roles.Where(x => x.RoleId == roleId).Select(x => x.RoleName).FirstOrDefault();
                return roleName;
            }
            catch (Exception)
            {
                return null;
            }
        }
        public List<Models.Products> GetProducts()
        {
            try
            {
                return _context.Products.ToList();
            }
            catch (Exception e)
            {
                return null;
            }
        }

        public string GetNextProductId()
        {
            string productId = _context.Products.OrderByDescending(x => x.ProductId).Select(x => x.ProductId).FirstOrDefault().ToString();
            int id = Convert.ToInt32(productId.Substring(1, productId.Length - 1)) + 1;
            return "P" + id.ToString();
        }


        public bool AddProduct(Products product)
        {
            try
            {
                _context.Products.Add(product);
                _context.SaveChanges();
                return true;
            }
            catch (Exception e)
            {
                return false;
            }
        }



        public bool UpdateProduct(Models.Products product)
        {
            try
            {
                Products dbProduct = _context.Products.Find(product.ProductId);
                dbProduct.ProductName = product.ProductName;
                dbProduct.QuantityAvailable = product.QuantityAvailable;
                dbProduct.Price = product.Price;
                dbProduct.CategoryId = product.CategoryId;

                _context.Products.Update(dbProduct);
                _context.SaveChanges();
                return true;
            }
            catch (Exception e)
            {
                return false;
            }
        }

        public bool DeleteProduct(string productId)
        {
            try
            {
                Models.Products prodObj = _context.Products.Find(productId);

                _context.Products.Remove(prodObj);
                _context.SaveChanges();
                return true;
            }
            catch (Exception e)
            {
                return false;
            }
        }

        public bool PurchaseProduct(Models.PurchaseDetails purchaseDetails)
        {
            try
            {
                _context.PurchaseDetails.Add(purchaseDetails);
                _context.SaveChanges();
                return true;
            }
            catch (Exception e)
            {
                return false;
            }
        }


        public List<string> FetchTopProducts()
        {
            List<string> productList = new List<string>();
            try
            {
                var list = (from c in _context.PurchaseDetails
                            join p in _context.Products on
                            c.ProductId equals p.ProductId
                            select p.ProductName).Distinct().ToList<string>();
                if (list.Count > 3)
                {
                    for (int i = 0; i < 3; i++)
                    {
                        productList.Add(list[i]);
                    }
                }
                else
                {
                    productList = list;
                }

            }
            catch
            {

                productList = null;
            }
            return productList;
        }

        public List<string> FetchTopProducts(string emailId)
        {
            List<string> productList = new List<string>();
            try
            {
                var list = (from c in _context.PurchaseDetails
                            join p in _context.Products on
                            c.ProductId equals p.ProductId
                            where c.EmailId == emailId
                            select p.ProductName).Distinct().ToList<string>();
                if (list.Count > 3)
                {
                    for (int i = 0; i < 3; i++)
                    {
                        productList.Add(list[i]);
                    }
                }
                else
                {
                    productList = list;
                }

            }
            catch
            {

                productList = null;
            }
            return productList;
        }
        public bool RegisterUser(string EmailId, string UserPassword, string Gender, DateTime DateOfBirth, string Address)
        {
            try
            {
                Users userObj = new Users();
                userObj.EmailId = EmailId;
                userObj.UserPassword = UserPassword;
                userObj.Gender = Gender;
                userObj.DateOfBirth = DateOfBirth;
                userObj.Address = Address;
                userObj.RoleId = 2;

                _context.Users.Add(userObj);
                _context.SaveChanges();
                return true;
            }
            catch (Exception e)
            {
                return false;
            }
        }

        public byte? ValidateCredentials(string userId, string password)
        {
            Users user = _context.Users.Find(userId);
            byte? roleId = null;
            if (user.UserPassword == password)
            {
                roleId = user.RoleId;
            }

            return roleId;
        }
    }
}
