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
-- Description:	
-- =============================================
CREATE PROCEDURE vecinos 
	-- Add the parameters for the stored procedure here
	@inIdCasa int = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	BEGIN TRY
		--validar que la casa exista
		DECLARE
					 @poligono GEOMETRY
					 ,@nPuntos INT
		IF (EXISTS(SELECT 
							1 
					FROM 
							dbo.lote AS L 
					WHERE 
							L.id = @inIdCasa 
					AND 
							L.tipoLote = 1)
		)
		BEGIN
			SELECT
					@poligono = L.terreno
			FROM
					dbo.lote AS L
			WHERE
					L.id = @inIdCasa
			
			
			SELECT 
					*
			FROM
					dbo.lote AS L
			WHERE
					L.id <> @inIdCasa--excepto si mismo
			AND
					(@poligono.STOverlaps(L.terreno) = 1
			OR
					@poligono.STTouches(L.terreno) = 1)
		END--fin del if
	END TRY
	BEGIN CATCH
		RETURN -1;
	END CATCH
    SET NOCOUNT OFF;
END
GO
