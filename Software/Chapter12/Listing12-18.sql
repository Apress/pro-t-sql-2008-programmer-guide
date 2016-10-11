USE AdventureWorks;
GO

DECLARE @x xml = N'<?xml version = "1.0"?>
<Geocode>
    <Info ID = "1">
        <Coordinates Resolution = "High">
            <Latitude>37.859609</Latitude>
            <Longitude>-122.291673</Longitude>
        </Coordinates>
        <Location Type = "Business">
            <Name>APress, Inc.</Name>
        </Location>
    </Info>
    <Info ID = "2">
        <Coordinates Resolution = "High">
            <Latitude>37.423268</Latitude>
            <Longitude>-122.086345</Longitude>
        </Coordinates>
        <Location Type = "Business">
            <Name>Google, Inc.</Name>
        </Location>
    </Info>
</Geocode>';

SELECT @x.query(N'//Location/parent::node()/Coordinates');
GO