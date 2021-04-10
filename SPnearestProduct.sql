-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Name
-- Create date: 
-- Description:	dado un id de producto retorn el id del comercio más cercano que lo tenga
-- =============================================
CREATE PROCEDURE nearestProduct 
	-- Add the parameters for the stored procedure here
	@inIdProducto int = 0, 
	@inPunto GEOMETRY = NULL,
	@outInt int = -1
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	BEGIN TRY
		--tabla de id validos
		DECLARE @tableIdLote TABLE
		(	SEC INT IDENTITY (1,1),
			idLote INT
			,punto GEOMETRY
		)
		DECLARE @high INT
				,@low INT
				,@nearestId INT
				,@nearestDistance REAL
				,@tmpPoint GEOMETRY
				,@tmpId INT
				,@tmpDistance REAL
		--validar que el producto exista

		SET @nearestId = -1;
		IF ( EXISTS (
					SELECT 
							1
					FROM
							dbo.producto AS P
					WHERE
							P.id = @inIdProducto
			)
		)
		BEGIN
			--meto todas las id de tablas que tengan el producto
			INSERT @tableIdLote
			(
					idLote
					,punto
			)
			SELECT
					L.id
					,L.terreno.STCentroid()
			FROM
					dbo.lote AS L
			INNER JOIN
					dbo.productoXLote AS PXL
			ON
					L.id = PXL.idLote
			INNER JOIN
					dbo.producto AS P
			ON
					PXL.idProducto = P.id
			WHERE
					P.id = @inIdProducto
			--AND
			--		PXL.cantidad > 0
		
			--incializa
		END--fin del if

		IF (EXISTS (SELECT 1 FROM @tableIdLote))
		BEGIN
			SELECT
					@high = MAX(SEC)
					,@low = MIN (SEC)
			FROM
					@tableIdLote

			

			
			SET @nearestDistance = 0
				

			WHILE @low <= @high
			BEGIN
				--selecciona el primer id y punto de la tabla variable
				SELECT
						@tmpId = TIL.idLote
						,@tmpDistance = TIL.punto.STDistance(@inPunto)
				FROM
						@tableIdLote AS TIL
				WHERE
						TIL.SEC = @low--0

				

				IF (@nearestDistance > @tmpDistance)
				BEGIN
						SET @nearestId = @tmpId;
						SET @nearestDistance = @tmpDistance
				END
				
				
				SET @low = @low + 1;
			END--fin while
		END-- fin del if de tabla variable
		RETURN @nearestId--retornara .1 si no lo encuentra
	END TRY
	BEGIN CATCH
		RETURN @outInt;
	END CATCH
    SET NOCOUNT OFF;
END
GO
