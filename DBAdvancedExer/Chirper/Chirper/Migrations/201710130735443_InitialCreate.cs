namespace Chirper.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class InitialCreate : DbMigration
    {
        public override void Up()
        {
          /*  CreateTable(
               "dbo.Chirps",
               c => new
               {
                   Id = c.Int(nullable: false, identity: true),
                   Content = c.String(),
                   AuthorId = c.Int(nullable: false),
               })
               .PrimaryKey(t => t.Id)
               .ForeignKey("dbo.Users", t => t.AuthorId, cascadeDelete: true)
               .Index(t => t.AuthorId);

            CreateTable(
               "dbo.Users",
               c => new
               {
                   Id = c.Int(nullable: false, identity: true),
                   Alias = c.String(),
               })
               .PrimaryKey(t => t.Id);*/
        }
        
        public override void Down()
        {
            /* DropForeignKey("dbo.Chirps", "AuthorId", "dbo.Users");
             DropIndex("dbo.Chirps", new[] { "AuthorId" });
             DropTable("dbo.Users");
             DropTable("dbo.Chirps");*/
        }
    }
}
