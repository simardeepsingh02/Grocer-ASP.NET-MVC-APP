using System;
using System.Collections.Generic;

namespace BuyHere.Models
{
    public partial class Products
    {
        public Products()
        {
            PurchaseDetails = new HashSet<PurchaseDetails>();
        }

        public string ProductId { get; set; }
        public string ProductName { get; set; }
        public byte? CategoryId { get; set; }
        public decimal Price { get; set; }
        public int QuantityAvailable { get; set; }

        public virtual Categories Category { get; set; }
        public virtual ICollection<PurchaseDetails> PurchaseDetails { get; set; }
    }
}
