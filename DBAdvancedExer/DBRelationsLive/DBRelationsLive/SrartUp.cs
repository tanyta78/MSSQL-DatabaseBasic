using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DBRelationsLive
{
   public class SrartUp
    {
       public static void Main()
        {
            RelationLiveContext context=new RelationLiveContext();

            context.Database.Initialize(true);
        }
    }
}
