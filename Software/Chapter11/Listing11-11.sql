USE AdventureWorks;
GO

DECLARE @x xml = N'<?xml version="1.0" ?>
        <Address>
            <Latitude>47.642737</Latitude>
            <Longitude>-122.130395</Longitude>
            <Street>ONE MICROSOFT WAY</Street>
            <City>REDMOND</City>
            <State>WA</State>
            <Zip>98052</Zip>
            <Country>US</Country>
        </Address>';

SELECT @x;
GO




