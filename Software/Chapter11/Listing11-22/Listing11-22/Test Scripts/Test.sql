-- Example XML to HTML conversion script, using XSLT. This listing is a combination of the following listings
-- from the book:
--
-- *  Listing 11-20: Retrieves data from Production.Product and Production.ProductInventory tables in XML format
-- *  Listing 11-21: Defines XSLT stylesheet for transformation
-- *  Listing 11-23: Calls SQL CLR SP to convert source XML to HTML with the XSLT stylesheet

DECLARE @xml xml = 
(
  SELECT
    p.ProductNumber AS "@Id",
    p.Name AS "Name",
    p.Color AS "Color",
    p.ListPrice AS "ListPrice",
    p.SizeUnitMeasureCode AS "Size/@UOM",
    p.Size AS "Size",
    p.WeightUnitMeasureCode AS "Weight/@UOM",
    p.Weight AS "Weight",
    (
      SELECT COALESCE(SUM(i.Quantity), 0)
      FROM Production.ProductInventory i
      WHERE i.ProductID = p.ProductID
    ) AS "QuantityOnHand"
  FROM Production.Product p
  WHERE p.FinishedGoodsFlag = 1
  ORDER BY p.Name
  FOR XML PATH ('Product'),
    ROOT ('Products')
);

DECLARE @xslt xml = N'<?xml version="1.0" encoding="utf-16"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/Products">
<html>
    <head>
        <title>AdventureWorks Product Listing Report</title>
        <style type="text/css">
            tr.row-heading {
                background-color: 000099;
                color: ffffff;
                font-family: tahoma, arial, helvetica, sans-serif;
                font-size: 12px;
            }
            tr.row-light {
                background-color: ffffff;
                font-family: tahoma, arial, helvetica, sans-serif;
                font-size: 12px;
            }
            tr.row-dark {
                background-color: 00ffff;
                font-family: tahoma, arial, helvetica, sans-serif;
                font-size: 12px;
            }
            td.col-right {
                text-align: right;
            }
        </style>
    </head>
    <body>
        <table>
            <tr class="row-heading">
                <th>ID</th>
                <th>Product Name</th>
                <th>On Hand</th>
                <th>List Price</th>
                <th>Color</th>
                <th>Size</th>
                <th>Weight</th>
            </tr>
            <xsl:for-each select="Product">
                <xsl:element name="tr">
                    <xsl:choose>
                        <xsl:when test="position() mod 2 = 0">
                            <xsl:attribute name="class">row-light</xsl:attribute>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:attribute name="class">row-dark</xsl:attribute>
                        </xsl:otherwise>
                    </xsl:choose>
                    <td><xsl:value-of select="@Id"/></td>
                    <td><xsl:value-of select="Name"/></td>
                    <td class="col-right">
                        <xsl:value-of select="QuantityOnHand"/>
                    </td>
                    <td class="col-right"><xsl:value-of select="ListPrice"/></td>
                    <td><xsl:value-of select="Color"/></td>
                    <td class="col-right">
                        <xsl:value-of select="Size"/>
                        <xsl:value-of select="Size/@UOM"/>
                    </td>
                    <td class="col-right">
                        <xsl:value-of select="Weight"/> 
                        <xsl:value-of select="Weight/@UOM"/>
                    </td>
                </xsl:element>
            </xsl:for-each>
        </table>
    </body>
</html>
</xsl:template>
</xsl:stylesheet>';

EXECUTE XmlToHtml @xml,
  @xslt,
  'c:\Documents and Settings\All Users\Documents\adventureworks-inventory.html';
