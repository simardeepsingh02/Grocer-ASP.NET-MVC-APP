using AutoMapper;
using BuyHere.Models;
namespace BuyHereApp.Repository
{
    public class BuyHereMapper: Profile
    {
            public BuyHereMapper()
            {
            CreateMap<Models.Products, Products>();
            CreateMap<Products, Models.Products>();
            }

    }
}
