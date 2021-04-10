USE [DB_Espacial]
GO

/****** Object:  StoredProcedure [dbo].[distanciaCasas]    Script Date: 9/4/2021 18:47:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Name
-- Create date: 
-- Description:	dados dos id de casas se obtiene el centro de sus poligonos
--y se calcula la distancia entre ellos
-- =============================================
CREATE PROCEDURE [dbo].[distanciaCasas] 
	-- Add the parameters for the stored procedure here
	@inCasa1 int = 0
	,@inCasa2 int = 0
	,@outInt int = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	BEGIN TRY
		DECLARE		@center1 GEOMETRY
					,@center2 GEOMETRY
					,@distance REAL

		--validar que las casas existan
		--FALTA validar que el tipo de lote sea de casa
		IF (EXISTS (
					SELECT 
							1
					FROM 
							dbo.lote AS L
					WHERE
							L.id = @inCasa1
					AND
							L.tipoLote = 1--es el id de casa
					)
			AND
			EXISTS (
					SELECT 
							1
					FROM 
							dbo.lote AS L
					WHERE
							L.id = @inCasa2
					AND
							L.tipoLote = 1--es el id de casa
					)
			)
		BEGIN
			--asigno los centros de los terrenos
			SELECT
					@center1 = L.terreno.STCentroid()
			FROM
					dbo.lote AS L
			WHERE
					L.id = @inCasa1;

			SELECT
					@center2 = L.terreno.STCentroid()
			FROM
					dbo.lote AS L
			WHERE
					L.id = @inCasa2;

			SET	@distance = @center1.STDistance(@center2);
			RETURN @distance
		END	--termina if
		
	END TRY
	BEGIN CATCH
		
		RETURN -1;--error
	END CATCH
    SET NOCOUNT OFF
END
GO


