namespace Chirper.Migrations
{
    using System.Data.Entity.Migrations;

    internal sealed class Configuration : DbMigrationsConfiguration<Chirper.ChirperContext>
    {
        public Configuration()
        {
            AutomaticMigrationsEnabled = false;
            ContextKey = "Chirper.ChirperContext";
        }

        protected override void Seed(Chirper.ChirperContext context)
        {
        }
    }
}
