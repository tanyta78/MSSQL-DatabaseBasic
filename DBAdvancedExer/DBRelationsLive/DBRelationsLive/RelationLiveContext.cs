namespace DBRelationsLive
{
    using System;
    using System.Data.Entity;
    using System.Linq;
    using Models;

    public class RelationLiveContext : DbContext
    {
        
        public RelationLiveContext()
            : base("name=RelationLiveContext")
        {
            Database.SetInitializer(new DropCreateDatabaseAlways<RelationLiveContext>());
        }

       
         public virtual DbSet<Student> Students { get; set; }
         public virtual DbSet<Address> Addresses { get; set; }

    }


}