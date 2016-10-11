// This is a code snippet

using System.Data.Services;

public class AdventureWorksDataService
  : DataService<AdventureWorksModel.AdventureWorksEntities>
{
    // This method is called only once to initialize service-wide policies.
    public static void InitializeService(IDataServiceConfiguration config)
    {
        config.SetEntitySetAccessRule("Product", EntitySetRights.AllRead);
        config.SetEntitySetAccessRule("ProductPhoto", EntitySetRights.AllRead);
        config.SetEntitySetAccessRule("ProductProductPhoto", EntitySetRights.AllRead);

        // Example for service operations
        // config.SetServiceOperationAccessRule("*", ServiceOperationRights.All);
    }
}