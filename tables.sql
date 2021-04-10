USE [DB_Espacial]
GO

/****** Object:  Table [dbo].[alameda]    Script Date: 9/4/2021 18:48:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[alameda](
	[id] [int] NOT NULL,
	[nombre] [nvarchar](50) NOT NULL,
	[barrio] [int] NOT NULL,
 CONSTRAINT [PK_alameda] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[barrio]    Script Date: 9/4/2021 18:48:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[barrio](
	[id] [int] NOT NULL,
	[nombre] [nvarchar](50) NOT NULL,
	[ciudad] [int] NOT NULL,
 CONSTRAINT [PK_barrio] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[calle]    Script Date: 9/4/2021 18:48:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[calle](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](50) NOT NULL,
	[idBarrio] [int] NOT NULL,
 CONSTRAINT [PK_calle] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[ciudad]    Script Date: 9/4/2021 18:48:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ciudad](
	[id] [int] NOT NULL,
	[nombre] [nvarchar](50) NOT NULL,
	[pais] [int] NOT NULL,
 CONSTRAINT [PK_ciudad] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[lote]    Script Date: 9/4/2021 18:48:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[lote](
	[id] [int] NOT NULL,
	[idCalle] [int] NOT NULL,
	[numeroLote] [int] NOT NULL,
	[tipoLote] [int] NOT NULL,
	[alameda] [int] NOT NULL,
	[terreno] [geometry] NOT NULL,
 CONSTRAINT [PK_lote] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table [dbo].[pais]    Script Date: 9/4/2021 18:48:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pais](
	[id] [int] NOT NULL,
	[nombre] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_pais] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[producto]    Script Date: 9/4/2021 18:48:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[producto](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](50) NOT NULL,
	[precio] [money] NOT NULL,
 CONSTRAINT [PK_producto] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[tipoLote]    Script Date: 9/4/2021 18:48:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tipoLote](
	[id] [int] NOT NULL,
	[tipoLote] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_tipoLote] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[alameda]  WITH CHECK ADD  CONSTRAINT [FK_alameda_barrio] FOREIGN KEY([barrio])
REFERENCES [dbo].[barrio] ([id])
GO

ALTER TABLE [dbo].[alameda] CHECK CONSTRAINT [FK_alameda_barrio]
GO

ALTER TABLE [dbo].[barrio]  WITH CHECK ADD  CONSTRAINT [FK_barrio_ciudad] FOREIGN KEY([ciudad])
REFERENCES [dbo].[ciudad] ([id])
GO

ALTER TABLE [dbo].[barrio] CHECK CONSTRAINT [FK_barrio_ciudad]
GO

ALTER TABLE [dbo].[calle]  WITH CHECK ADD  CONSTRAINT [FK_calle_barrio] FOREIGN KEY([idBarrio])
REFERENCES [dbo].[barrio] ([id])
GO

ALTER TABLE [dbo].[calle] CHECK CONSTRAINT [FK_calle_barrio]
GO

ALTER TABLE [dbo].[ciudad]  WITH CHECK ADD  CONSTRAINT [FK_ciudad_pais] FOREIGN KEY([pais])
REFERENCES [dbo].[pais] ([id])
GO

ALTER TABLE [dbo].[ciudad] CHECK CONSTRAINT [FK_ciudad_pais]
GO

ALTER TABLE [dbo].[lote]  WITH CHECK ADD  CONSTRAINT [FK_lote_alameda] FOREIGN KEY([alameda])
REFERENCES [dbo].[alameda] ([id])
GO

ALTER TABLE [dbo].[lote] CHECK CONSTRAINT [FK_lote_alameda]
GO

ALTER TABLE [dbo].[lote]  WITH CHECK ADD  CONSTRAINT [FK_lote_calle] FOREIGN KEY([idCalle])
REFERENCES [dbo].[calle] ([id])
GO

ALTER TABLE [dbo].[lote] CHECK CONSTRAINT [FK_lote_calle]
GO

ALTER TABLE [dbo].[lote]  WITH CHECK ADD  CONSTRAINT [FK_lote_tipoLote] FOREIGN KEY([tipoLote])
REFERENCES [dbo].[tipoLote] ([id])
GO

ALTER TABLE [dbo].[lote] CHECK CONSTRAINT [FK_lote_tipoLote]
GO


