using System;
using BuyHere;
using BuyHere.Models;

namespace ConsoleApp1
{
    internal class Program
    {
        static void Main(string[] args)
        {
            BuyHereContext b = new BuyHereContext();
            BuyHereRepo a = new BuyHereRepo(b);
            byte? ab=a.ValidateCredentials("Franken@gmail.com", "BSBEV@1234");
            Console.WriteLine(ab);

        }
    }
}
