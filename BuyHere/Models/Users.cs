using System;
using System.Collections.Generic;

namespace BuyHere.Models
{
    public partial class Users
    {
        public Users()
        {
            PurchaseDetails = new HashSet<PurchaseDetails>();
        }

        public string EmailId { get; set; }
        public string UserPassword { get; set; }
        public byte? RoleId { get; set; }
        public string Gender { get; set; }
        public DateTime DateOfBirth { get; set; }
        public string Address { get; set; }

        public virtual Roles Role { get; set; }
        public virtual ICollection<PurchaseDetails> PurchaseDetails { get; set; }
    }
}
