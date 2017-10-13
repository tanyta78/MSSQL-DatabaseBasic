namespace Chirper
{
    using System.Data.Entity;
    using ModelConfigurations;
    using Models;

    public class ChirperContext : DbContext
    {
        public ChirperContext()
            : base("name=ChirperContext")
        {
        }

        public virtual DbSet<User> Users { get; set; }

        public virtual DbSet<Chirp> Chirps { get; set; }

        public virtual DbSet<ChImg> ChImgs { get; set; }

        public virtual DbSet<Comment> Comments { get; set; }

        public virtual DbSet<Tag> Tags { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Configurations.Add(new UserConfiguration());

            modelBuilder.Configurations.Add(new ChirpConfiguration());

            modelBuilder.Configurations.Add(new ChImgConfiguration());

            modelBuilder.Configurations.Add(new TagConfiguration());

            modelBuilder.Configurations.Add(new CommentConfiguration());

            base.OnModelCreating(modelBuilder);
        }
    }
}