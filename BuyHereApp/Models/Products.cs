using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace BuyHereApp.Models
{
    public partial class Products
    {
        [Required]
        public string ProductId { get; set; }
        [Required]
        public string ProductName { get; set; }
        [Required]
        public byte? CategoryId { get; set; }
        [Required]
        public decimal Price { get; set; }
        [Required]
        public int QuantityAvailable { get; set; }

        public virtual Categories Category { get; set; }
        public virtual ICollection<PurchaseDetails> PurchaseDetails { get; set; }
    }
}
