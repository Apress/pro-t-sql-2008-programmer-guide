using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Services.Client;
using AdventureWorksModel;

public partial class GetImage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ProductProductPhoto p = new ProductProductPhoto();
        DataServiceContext ctx = new DataServiceContext(new Uri("http://localhost:2149/Listing16-05/AdventureWorksDataService.svc"));//"http://localhost:1428/AdvSearchService/AdventureWorksDataService.svc"));
        DataServiceQuery<ProductProductPhoto> qry = ctx.CreateQuery<ProductProductPhoto>(string.Format("/Product({0})/ProductProductPhoto?$top=1&$expand=ProductPhoto", Request.QueryString["id"].ToString()));
        foreach (ProductProductPhoto p1 in qry.Execute())
        {
            p = p1;
        }
        Response.ContentType = "Image/JPEG";
        Response.BinaryWrite(p.ProductPhoto.LargePhoto);
    }
}
