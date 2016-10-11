using System.Data.Services;

public class AdventureWorksDataService : DataService<AdventureWorksModel.AdventureWorksEntities>
{
    // This method is called only once to initialize service-wide policies.
    public static void InitializeService(IDataServiceConfiguration config)
    {
        // Example for entity sets (this example uses "AllRead" which allows reads but not writes)
        config.SetEntitySetAccessRule("Product", EntitySetRights.AllRead);
        config.SetEntitySetAccessRule("ProductPhoto", EntitySetRights.AllRead);
        config.SetEntitySetAccessRule("ProductProductPhoto", EntitySetRights.AllRead);

        // Example for service operations
        config.SetServiceOperationAccessRule("*", ServiceOperationRights.All);
    }
}
