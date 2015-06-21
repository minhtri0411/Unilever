﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace UnileverDAL
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    using System.Data.Entity.Core.Objects;
    using System.Linq;
    
    public partial class UnileverEntities : DbContext
    {
        public UnileverEntities()
            : base("name=UnileverEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<Category> Categories { get; set; }
        public virtual DbSet<DefferredLiability> DefferredLiabilities { get; set; }
        public virtual DbSet<Distributor> Distributors { get; set; }
        public virtual DbSet<InterestRate> InterestRates { get; set; }
        public virtual DbSet<Inventory> Inventories { get; set; }
        public virtual DbSet<OrderDetail> OrderDetails { get; set; }
        public virtual DbSet<Order> Orders { get; set; }
        public virtual DbSet<OrderType> OrderTypes { get; set; }
        public virtual DbSet<Product> Products { get; set; }
    
        public virtual ObjectResult<sp_getDistributorLiabilitiesSumary_Result> sp_getDistributorLiabilitiesSumary(Nullable<int> distribid)
        {
            var distribidParameter = distribid.HasValue ?
                new ObjectParameter("distribid", distribid) :
                new ObjectParameter("distribid", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<sp_getDistributorLiabilitiesSumary_Result>("sp_getDistributorLiabilitiesSumary", distribidParameter);
        }
    }
}
