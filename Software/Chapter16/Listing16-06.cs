// This is a code snippet.

using System;
using System.Web.UI.WebControls;
using System.Data.Services.Client;
using AdventureWorksModel;

public partial class _Default : System.Web.UI.Page 
{
  protected void Page_Load(object sender, EventArgs e)
  {
    PopulateDropDown();
  }

  private void PopulateDropDown()
  {
    DataServiceContext ctx = new DataServiceContext
    (
      new Uri
        ("http://localhost:1428/AdvSearchService/AdventureWorksDataService.svc")
    );

    DataServiceQuery<Product> qry = 
      ctx.CreateQuery<Product>
        (
          "/Product?$filter=FinishedGoodsFlag eq true&$orderby=Name asc"
        );

    foreach (Product p in qry.Execute())
    {
      ProductDropDown.Items.Add(new ListItem(p.Name, p.ProductID.ToString()));
    }

    string id = ProductDropDown.SelectedValue;
    UpdateImage(id);
  }

  private void UpdateImage(string id)
  {
    ProductImage.ImageUrl = string.Format("GetImage.aspx?id={0}", id);
  }

  protected void ProductDropDownList_SelectedIndexChanged(object sender, 
    EventArgs e)
  {
    string id = ProductDropDown.SelectedValue;
    DataServiceContext ctx = new DataServiceContext
    (
      new Uri
        ("http://localhost:1428/AdvSearchService/AdventureWorksDataService.svc")
    );

    DataServiceQuery<Product> qry = 
      ctx.CreateQuery<Product>(string.Format("/Product({0})", id));

    foreach (Product p in qry.Execute())
    {
      Table1.Rows[0].Cells[1].Text = p.Class;
      Table1.Rows[1].Cells[1].Text = p.Color;
      Table1.Rows[2].Cells[1].Text = p.Size + " " + p.SizeUnitMeasureCode;
      Table1.Rows[3].Cells[1].Text = p.Weight + " " + p.WeightUnitMeasureCode;
      Table1.Rows[4].Cells[1].Text = p.ListPrice.ToString();
      Table1.Rows[5].Cells[1].Text = p.ProductNumber; 
    }
    UpdateImage(id);
  }
}
