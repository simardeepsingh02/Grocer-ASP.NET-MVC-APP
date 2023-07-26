using System;
using System.Collections.Generic;

namespace BuyHere.Models
{
    public partial class Roles
    {
        public Roles()
        {
            Users = new HashSet<Users>();
        }

        public byte RoleId { get; set; }
        public string RoleName { get; set; }

        public virtual ICollection<Users> Users { get; set; }
    }
}
