USE AdventureWorks;
GO

DECLARE @Wyoming geography,
	@StatueOfLiberty geography,
	@Laramie geography;

SET @Wyoming = geography::GeomFromGml ('<Polygon
	xmlns="http://www.opengis.net/gml">
	<exterior>
		<LinearRing>
			<posList>
				41.698246 -104.053108 41.999851 -104.053009
				43.003094 -104.05571 43.503738 -104.057426
				44.145844 -104.059242 44.574368 -104.058975
				45.001091 -105.04126 44.997227 -106.020576
				44.999813 -107.893715 44.997643 -108.624573
				45.002853 -109.994789 44.992348 -110.428894
				44.664562 -111.050842 43.982632 -111.049629
				43.284813 -111.04673 42.503323 -111.046028
				41.578648 -111.050323 40.996635 -111.050285
				40.997646 -110.001457 41.00341 -107.918037
				40.998489 -106.864838 41.000111 -106.202896
				40.994305 -104.933968 41.388107 -104.053505
				41.698246 -104.053108
			</posList>
		</LinearRing>
	</exterior>
</Polygon>', 4269);

SET @StatueOfLiberty = geography::GeomFromGml('<Point
	xmlns="http://www.opengis.net/gml">
	<pos>
		40.689124 -74.044483
	</pos>
</Point>', 4269);

SET @Laramie = geography::GeomFromGml('<Point
	xmlns="http://www.opengis.net/gml">
	<pos>
		41.312928 -105.587253
	</pos>
</Point>', 4269);

SELECT 'Is the Statue of Liberty in Wyoming?',
	CASE @Wyoming.STIntersects(@StatueOfLiberty)
		WHEN 0 THEN 'No'
		ELSE 'Yes'
		END AS Answer

UNION

SELECT 'Is Laramie in Wyoming?',
	CASE @Wyoming.STIntersects(@Laramie)
		WHEN 0 THEN 'No'
		ELSE 'Yes'
		END;
GO
