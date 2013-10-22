SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
IF EXISTS (SELECT * FROM tempdb..sysobjects WHERE id=OBJECT_ID('tempdb..#tmpErrors')) DROP TABLE #tmpErrors
GO
CREATE TABLE #tmpErrors (Error int)
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
GO
PRINT N'Dropping Unused Stored Procedures'
--IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dashCommerce_Store_ProductSearch]') AND type in (N'P', N'PC'))
--DROP PROCEDURE [dbo].[dashCommerce_Store_ProductSearch]
--GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dashCommerce_Core_FetchAllLogs]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dashCommerce_Core_FetchAllLogs]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dashCommerce_Core_Insert_Log]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dashCommerce_Core_Insert_Log]
GO
--PRINT N'Dropping Full Text Indexes'
--IF OBJECTPROPERTY (object_id('dashCommerce_Store_Product'),'TableHasActiveFulltextIndex ') = 1
--DROP FULLTEXT INDEX ON [dbo].[dashCommerce_Store_Product]
--GO

--IF EXISTS (SELECT * FROM sys.fulltext_catalogs WHERE name = N'dashCommerce_Catalog')
--DROP FULLTEXT CATALOG dashCommerce_Catalog
--GO
BEGIN TRANSACTION
GO
PRINT N'Dropping foreign keys from [dbo].[dashCommerce_Store_CustomizedProductDisplayType_Product_Map]'
GO
ALTER TABLE [dbo].[dashCommerce_Store_CustomizedProductDisplayType_Product_Map] DROP
CONSTRAINT [FK_dashCommerce_Store_CustomizedProductDisplayType_Product_Map_dashCommerce_Store_CustomizedProductDisplayTypes],
CONSTRAINT [FK_CustomizedProductsDisplayType_Product_Map_dashCommerce_Store_Product]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping foreign keys from [dbo].[dashCommerce_Store_Order]'
GO
ALTER TABLE [dbo].[dashCommerce_Store_Order] DROP
CONSTRAINT [FK_dashCommerce_Store_Order_dashCommerce_Store_OrderStatusDescriptor]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping foreign keys from [dbo].[dashCommerce_Store_OrderNote]'
GO
ALTER TABLE [dbo].[dashCommerce_Store_OrderNote] DROP
CONSTRAINT [FK_dashCommerce_Store_OrderNote_dashCommerce_Store_Order]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping foreign keys from [dbo].[dashCommerce_Store_Product]'
GO
ALTER TABLE [dbo].[dashCommerce_Store_Product] DROP
CONSTRAINT [FK_dashCommerce_Products_dashCommerce_ProductStatus]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping foreign keys from [dbo].[dashCommerce_Store_Transaction]'
GO
ALTER TABLE [dbo].[dashCommerce_Store_Transaction] DROP
CONSTRAINT [FK_dashCommerce_OrderTransactions_dashCommerce_OrderTransactionTypes]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[dashCommerce_Store_ProductRating]'
GO
ALTER TABLE [dbo].[dashCommerce_Store_ProductRating] DROP CONSTRAINT [PK_dashCommerce_ProductRating]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[dashCommerce_Core_Log]'
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Script_Message_Log_Log_Date]') AND type = 'D')
ALTER TABLE [dbo].[dashCommerce_Core_Log] DROP CONSTRAINT [DF_Script_Message_Log_Log_Date]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[dashCommerce_Store_ProductRating]'
GO
ALTER TABLE [dbo].[dashCommerce_Store_ProductRating] DROP CONSTRAINT [DF_dashCommerce_Store_Rating_createdOn]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[dashCommerce_Store_ProductRating]'
GO
ALTER TABLE [dbo].[dashCommerce_Store_ProductRating] DROP CONSTRAINT [DF_dashCommerce_Store_Rating_modifiedOn]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[dashCommerce_Store_SimpleWeight_Shipping_Rate]'
GO
ALTER TABLE [dbo].[dashCommerce_Store_SimpleWeight_Shipping_Rate] DROP CONSTRAINT [PK_dashCommerce_ShippingRates]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[dashCommerce_Store_SimpleWeight_Shipping_Rate]'
GO
ALTER TABLE [dbo].[dashCommerce_Store_SimpleWeight_Shipping_Rate] DROP CONSTRAINT [DF_dashCommerce_Shipping_Rate_createdOn]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[dashCommerce_Store_SimpleWeight_Shipping_Rate]'
GO
ALTER TABLE [dbo].[dashCommerce_Store_SimpleWeight_Shipping_Rate] DROP CONSTRAINT [DF_dashCommerce_Shipping_Rate_modifiedOn]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[dashCommerce_Store_OrderStatusDescriptor]'
GO
ALTER TABLE [dbo].[dashCommerce_Store_OrderStatusDescriptor] DROP CONSTRAINT [PK_dashCommerce_Store_OrderStatusDescriptor]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[dashCommerce_Store_OrderStatusDescriptor]'
GO
ALTER TABLE [dbo].[dashCommerce_Store_OrderStatusDescriptor] DROP CONSTRAINT [DF_dashCommerce_Store_OrderStatusDescriptor_CreatedOn]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[dashCommerce_Store_OrderStatusDescriptor]'
GO
ALTER TABLE [dbo].[dashCommerce_Store_OrderStatusDescriptor] DROP CONSTRAINT [DF_dashCommerce_Store_OrderStatusDescriptor_ModifiedOn]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[dashCommerce_Store_CustomizedProductDisplayTypes]'
GO
ALTER TABLE [dbo].[dashCommerce_Store_CustomizedProductDisplayTypes] DROP CONSTRAINT [PK_dashCommerce_Content_CustomizedProductsDisplayTypes]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[dashCommerce_Store_CustomizedProductDisplayTypes]'
GO
ALTER TABLE [dbo].[dashCommerce_Store_CustomizedProductDisplayTypes] DROP CONSTRAINT [DF_dashCommerce_Content_CustomizedProductsDisplayTypes_CreatedOn]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[dashCommerce_Store_CustomizedProductDisplayTypes]'
GO
ALTER TABLE [dbo].[dashCommerce_Store_CustomizedProductDisplayTypes] DROP CONSTRAINT [DF_dashCommerce_Content_CustomizedProductsDisplayTypes_ModifiedOn]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[dashCommerce_Store_TransactionTypeDescriptor]'
GO
ALTER TABLE [dbo].[dashCommerce_Store_TransactionTypeDescriptor] DROP CONSTRAINT [PK_dashCommerce_OrderTransactionTypes]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[dashCommerce_Store_TransactionTypeDescriptor]'
GO
ALTER TABLE [dbo].[dashCommerce_Store_TransactionTypeDescriptor] DROP CONSTRAINT [DF_dashCommerce_Store_TransactionType_createdOn]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[dashCommerce_Store_TransactionTypeDescriptor]'
GO
ALTER TABLE [dbo].[dashCommerce_Store_TransactionTypeDescriptor] DROP CONSTRAINT [DF_dashCommerce_Store_TransactionType_modifiedOn]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[dashCommerce_Store_OrderNote]'
GO
ALTER TABLE [dbo].[dashCommerce_Store_OrderNote] DROP CONSTRAINT [PK_dashCommerce_OrderNotes]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[dashCommerce_Store_OrderNote]'
GO
ALTER TABLE [dbo].[dashCommerce_Store_OrderNote] DROP CONSTRAINT [DF_dashCommerce_Store_OrderNote_createdOn]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[dashCommerce_Store_OrderNote]'
GO
ALTER TABLE [dbo].[dashCommerce_Store_OrderNote] DROP CONSTRAINT [DF_dashCommerce_Store_OrderNote_modifiedOn]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[dashCommerce_Store_ProductStatusDescriptor]'
GO
ALTER TABLE [dbo].[dashCommerce_Store_ProductStatusDescriptor] DROP CONSTRAINT [PK_dashCommerce_ProductStatus]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[dashCommerce_Store_ProductStatusDescriptor]'
GO
ALTER TABLE [dbo].[dashCommerce_Store_ProductStatusDescriptor] DROP CONSTRAINT [DF_dashCommerce_Store_ProductStatus_createdOn]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[dashCommerce_Store_ProductStatusDescriptor]'
GO
ALTER TABLE [dbo].[dashCommerce_Store_ProductStatusDescriptor] DROP CONSTRAINT [DF_dashCommerce_Store_ProductStatus_modifiedOn]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[dashCommerce_Store_RegionCode_Tax_Rate]'
GO
ALTER TABLE [dbo].[dashCommerce_Store_RegionCode_Tax_Rate] DROP CONSTRAINT [PK_dashCommerce_Taxes]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[dashCommerce_Store_RegionCode_Tax_Rate]'
GO
ALTER TABLE [dbo].[dashCommerce_Store_RegionCode_Tax_Rate] DROP CONSTRAINT [DF_dashCommerce_Tax_Rate_createdOn]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[dashCommerce_Store_RegionCode_Tax_Rate]'
GO
ALTER TABLE [dbo].[dashCommerce_Store_RegionCode_Tax_Rate] DROP CONSTRAINT [DF_dashCommerce_Tax_Rate_modifiedOn]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[dashCommerce_Store_CustomizedProductDisplayType_Product_Map]'
GO
ALTER TABLE [dbo].[dashCommerce_Store_CustomizedProductDisplayType_Product_Map] DROP CONSTRAINT [PK_CustomizedProductsDisplayType_Product_Map]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
-- START PK and FK Mod Tables
PRINT N'Rebuilding [dbo].[dashCommerce_Store_CustomizedProductDisplayType_Product_Map]'
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
SET XACT_ABORT ON
GO
BEGIN TRANSACTION
CREATE TABLE [dbo].[tmp_ms_xx_dashCommerce_Store_CustomizedProductDisplayType_Product_Map]
(
[CustomizedProductDisplayTypeId] [int] NOT NULL,
[ProductId] [int] NOT NULL
) ON [PRIMARY]
INSERT INTO [dbo].[tmp_ms_xx_dashCommerce_Store_CustomizedProductDisplayType_Product_Map]([CustomizedProductDisplayTypeId],[ProductId]) SELECT [CustomizedProductsDisplayTypeId],[ProductId] FROM [dbo].[dashCommerce_Store_CustomizedProductDisplayType_Product_Map]
DROP TABLE [dbo].[dashCommerce_Store_CustomizedProductDisplayType_Product_Map]
EXEC sp_rename N'[dbo].[tmp_ms_xx_dashCommerce_Store_CustomizedProductDisplayType_Product_Map]', N'dashCommerce_Store_CustomizedProductDisplayType_Product_Map'
COMMIT TRANSACTION
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
GO
PRINT N'Creating primary key [PK_CustomizedProductsDisplayType_Product_Map] on [dbo].[dashCommerce_Store_CustomizedProductDisplayType_Product_Map]'
GO
ALTER TABLE [dbo].[dashCommerce_Store_CustomizedProductDisplayType_Product_Map] ADD CONSTRAINT [PK_CustomizedProductsDisplayType_Product_Map] PRIMARY KEY CLUSTERED  ([CustomizedProductDisplayTypeId], [ProductId]) ON [PRIMARY]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[dashCommerce_Store_CustomizedProductDisplayType]'
GO
CREATE TABLE [dbo].[dashCommerce_Store_CustomizedProductDisplayType]
(
[CustomizedProductDisplayTypeId] [int] NOT NULL IDENTITY(1, 1),
[Name] [nvarchar] (50) NOT NULL,
[CreatedBy] [nvarchar] (50) NOT NULL,
[CreatedOn] [datetime] NOT NULL CONSTRAINT [DF_dashCommerce_Content_CustomizedProductsDisplayTypes_CreatedOn] DEFAULT (getutcdate()),
[ModifiedBy] [nvarchar] (50) NOT NULL,
[ModifiedOn] [datetime] NOT NULL CONSTRAINT [DF_dashCommerce_Content_CustomizedProductsDisplayTypes_ModifiedOn] DEFAULT (getutcdate())
) ON [PRIMARY]
SET IDENTITY_INSERT [dbo].[dashCommerce_Store_CustomizedProductDisplayType] ON
INSERT INTO [dbo].[dashCommerce_Store_CustomizedProductDisplayType]([CustomizedProductDisplayTypeId], [Name], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) SELECT [CustomizedProductsDisplayTypeId], [Name], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn] FROM [dbo].[dashCommerce_Store_CustomizedProductDisplayTypes]
SET IDENTITY_INSERT [dbo].[dashCommerce_Store_CustomizedProductDisplayType] OFF
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_dashCommerce_Content_CustomizedProductDisplayType] on [dbo].[dashCommerce_Store_CustomizedProductDisplayType]'
GO
ALTER TABLE [dbo].[dashCommerce_Store_CustomizedProductDisplayType] ADD CONSTRAINT [PK_dashCommerce_Content_CustomizedProductDisplayType] PRIMARY KEY CLUSTERED  ([CustomizedProductDisplayTypeId]) ON [PRIMARY]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[dashCommerce_Store_CustomizedProductDisplayTypes]'
GO
DROP TABLE [dbo].[dashCommerce_Store_CustomizedProductDisplayTypes]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Rebuilding [dbo].[dashCommerce_Store_OrderStatusDescriptor]'
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
SET XACT_ABORT ON
GO
BEGIN TRANSACTION
CREATE TABLE [dbo].[tmp_ms_xx_dashCommerce_Store_OrderStatusDescriptor]
(
[OrderStatusDescriptorId] [int] NOT NULL IDENTITY(1,1),
[Name] [nvarchar] (100) NOT NULL,
[CreatedBy] [nvarchar] (50) NULL,
[CreatedOn] [datetime] NOT NULL CONSTRAINT [DF_dashCommerce_Store_OrderStatusDescriptor_CreatedOn] DEFAULT (getutcdate()),
[ModifiedBy] [nvarchar] (50) NULL,
[ModifiedOn] [datetime] NOT NULL CONSTRAINT [DF_dashCommerce_Store_OrderStatusDescriptor_ModifiedOn] DEFAULT (getutcdate())
) ON [PRIMARY]
SET IDENTITY_INSERT [dbo].[tmp_ms_xx_dashCommerce_Store_OrderStatusDescriptor] ON
INSERT INTO [dbo].[tmp_ms_xx_dashCommerce_Store_OrderStatusDescriptor]([OrderStatusDescriptorId], [Name], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) SELECT [OrderStatusId], [Name], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn] FROM [dbo].[dashCommerce_Store_OrderStatusDescriptor]
SET IDENTITY_INSERT [dbo].[tmp_ms_xx_dashCommerce_Store_OrderStatusDescriptor] OFF
DROP TABLE [dbo].[dashCommerce_Store_OrderStatusDescriptor]
EXEC sp_rename N'[dbo].[tmp_ms_xx_dashCommerce_Store_OrderStatusDescriptor]', N'dashCommerce_Store_OrderStatusDescriptor'
EXEC sp_rename N'[dbo].[dashCommerce_Store_Order].[OrderStatusId]', N'OrderStatusDescriptorId', 'COLUMN'
COMMIT TRANSACTION
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
GO
PRINT N'Creating primary key [PK_dashCommerce_Store_OrderStatusDescriptor] on [dbo].[dashCommerce_Store_OrderStatusDescriptor]'
GO
ALTER TABLE [dbo].[dashCommerce_Store_OrderStatusDescriptor] ADD CONSTRAINT [PK_dashCommerce_Store_OrderStatusDescriptor] PRIMARY KEY CLUSTERED  ([OrderStatusDescriptorId]) ON [PRIMARY]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Rebuilding [dbo].[dashCommerce_Store_OrderNote]'
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
SET XACT_ABORT ON
GO
BEGIN TRANSACTION
CREATE TABLE [dbo].[tmp_ms_xx_dashCommerce_Store_OrderNote]
(
[OrderNoteId] [int] NOT NULL IDENTITY(1, 1),
[OrderId] [int] NOT NULL,
[Note] [nvarchar] (1500) NOT NULL,
[CreatedBy] [nvarchar] (50) NULL,
[CreatedOn] [datetime] NOT NULL CONSTRAINT [DF_dashCommerce_Store_OrderNote_createdOn] DEFAULT (getutcdate()),
[ModifiedBy] [nvarchar] (50) NULL,
[ModifiedOn] [datetime] NOT NULL CONSTRAINT [DF_dashCommerce_Store_OrderNote_modifiedOn] DEFAULT (getutcdate())
) ON [PRIMARY]
SET IDENTITY_INSERT [dbo].[tmp_ms_xx_dashCommerce_Store_OrderNote] ON
INSERT INTO [dbo].[tmp_ms_xx_dashCommerce_Store_OrderNote]([OrderNoteId], [OrderId], [Note], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) SELECT [NoteId], [OrderId], [Note], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn] FROM [dbo].[dashCommerce_Store_OrderNote]
SET IDENTITY_INSERT [dbo].[tmp_ms_xx_dashCommerce_Store_OrderNote] OFF
DROP TABLE [dbo].[dashCommerce_Store_OrderNote]
EXEC sp_rename N'[dbo].[tmp_ms_xx_dashCommerce_Store_OrderNote]', N'dashCommerce_Store_OrderNote'
COMMIT TRANSACTION
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
GO
PRINT N'Creating primary key [PK_dashCommerce_OrderNotes] on [dbo].[dashCommerce_Store_OrderNote]'
GO
ALTER TABLE [dbo].[dashCommerce_Store_OrderNote] ADD CONSTRAINT [PK_dashCommerce_OrderNotes] PRIMARY KEY CLUSTERED  ([OrderNoteId]) ON [PRIMARY]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Rebuilding [dbo].[dashCommerce_Store_ProductStatusDescriptor]'
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
SET XACT_ABORT ON
GO
BEGIN TRANSACTION
CREATE TABLE [dbo].[tmp_ms_xx_dashCommerce_Store_ProductStatusDescriptor]
(
[ProductStatusDescriptorId] [int] NOT NULL IDENTITY(1, 1),
[Name] [nvarchar] (50) NOT NULL,
[CreatedBy] [nvarchar] (50) NULL,
[CreatedOn] [datetime] NOT NULL CONSTRAINT [DF_dashCommerce_Store_ProductStatus_createdOn] DEFAULT (getutcdate()),
[ModifiedBy] [nvarchar] (50) NULL,
[ModifiedOn] [datetime] NOT NULL CONSTRAINT [DF_dashCommerce_Store_ProductStatus_modifiedOn] DEFAULT (getutcdate())
) ON [PRIMARY]
SET IDENTITY_INSERT [dbo].[tmp_ms_xx_dashCommerce_Store_ProductStatusDescriptor] ON
INSERT INTO [dbo].[tmp_ms_xx_dashCommerce_Store_ProductStatusDescriptor]([ProductStatusDescriptorId], [Name], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) SELECT [StatusId], [Name], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn] FROM [dbo].[dashCommerce_Store_ProductStatusDescriptor]
SET IDENTITY_INSERT [dbo].[tmp_ms_xx_dashCommerce_Store_ProductStatusDescriptor] OFF
DROP TABLE [dbo].[dashCommerce_Store_ProductStatusDescriptor]
EXEC sp_rename N'[dbo].[tmp_ms_xx_dashCommerce_Store_ProductStatusDescriptor]', N'dashCommerce_Store_ProductStatusDescriptor'
EXEC sp_rename N'[dbo].[dashCommerce_Store_Product].[StatusId]', N'ProductStatusDescriptorId', 'COLUMN'
COMMIT TRANSACTION
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
GO
PRINT N'Creating primary key [PK_dashCommerce_ProductStatus] on [dbo].[dashCommerce_Store_ProductStatusDescriptor]'
GO
ALTER TABLE [dbo].[dashCommerce_Store_ProductStatusDescriptor] ADD CONSTRAINT [PK_dashCommerce_ProductStatus] PRIMARY KEY CLUSTERED  ([ProductStatusDescriptorId]) ON [PRIMARY]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Rebuilding [dbo].[dashCommerce_Store_TransactionTypeDescriptor]'
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
SET XACT_ABORT ON
GO
BEGIN TRANSACTION
CREATE TABLE [dbo].[tmp_ms_xx_dashCommerce_Store_TransactionTypeDescriptor]
(
[TransactionTypeDescriptorId] [int] NOT NULL IDENTITY(1, 1),
[Name] [nvarchar] (50) NOT NULL,
[CreatedBy] [nvarchar] (50) NULL,
[CreatedOn] [datetime] NOT NULL CONSTRAINT [DF_dashCommerce_Store_TransactionType_createdOn] DEFAULT (getutcdate()),
[ModifiedBy] [nvarchar] (50) NULL,
[ModifiedOn] [datetime] NOT NULL CONSTRAINT [DF_dashCommerce_Store_TransactionType_modifiedOn] DEFAULT (getutcdate())
) ON [PRIMARY]
SET IDENTITY_INSERT [dbo].[tmp_ms_xx_dashCommerce_Store_TransactionTypeDescriptor] ON
INSERT INTO [dbo].[tmp_ms_xx_dashCommerce_Store_TransactionTypeDescriptor]([TransactionTypeDescriptorId], [Name], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) SELECT [TransactionTypeId], [Name], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn] FROM [dbo].[dashCommerce_Store_TransactionTypeDescriptor]
SET IDENTITY_INSERT [dbo].[tmp_ms_xx_dashCommerce_Store_TransactionTypeDescriptor] OFF
DROP TABLE [dbo].[dashCommerce_Store_TransactionTypeDescriptor]
EXEC sp_rename N'[dbo].[tmp_ms_xx_dashCommerce_Store_TransactionTypeDescriptor]', N'dashCommerce_Store_TransactionTypeDescriptor'
EXEC sp_rename N'[dbo].[dashCommerce_Store_Transaction].[TransactionTypeId]', N'TransactionTypeDescriptorId', 'COLUMN'
COMMIT TRANSACTION
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
GO
PRINT N'Creating primary key [PK_dashCommerce_OrderTransactionTypes] on [dbo].[dashCommerce_Store_TransactionTypeDescriptor]'
GO
ALTER TABLE [dbo].[dashCommerce_Store_TransactionTypeDescriptor] ADD CONSTRAINT [PK_dashCommerce_OrderTransactionTypes] PRIMARY KEY CLUSTERED  ([TransactionTypeDescriptorId]) ON [PRIMARY]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
/****** Object:  Table [dbo].[dashCommerce_Store_Download]    Script Date: 05/16/2009 13:24:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dashCommerce_Store_Download]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[dashCommerce_Store_Download](
	[DownloadId] [int] IDENTITY(1,1) NOT NULL,
	[DownloadFile] [nvarchar](255) NOT NULL,
	[Title] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[ForPurchaseOnly] [bit] NOT NULL,
	[ContentType] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[ModifiedBy] [nvarchar](50) NOT NULL,
	[ModifiedOn] [datetime] NOT NULL,
 CONSTRAINT [PK_dashCommerce_Store_Download] PRIMARY KEY CLUSTERED 
(
	[DownloadId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
)
END
GO
/****** Object:  Table [dbo].[dashCommerce_Store_DownloadAccessControl]    Script Date: 05/16/2009 13:24:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dashCommerce_Store_DownloadAccessControl]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[dashCommerce_Store_DownloadAccessControl](
	[UserId] [uniqueidentifier] NOT NULL,
	[DownloadId] [int] NOT NULL,
 CONSTRAINT [PK_dashCommerce_Store_DownloadAccessControl] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[DownloadId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
)
END
GO
/****** Object:  Default [DF_dashCommerce_Store_Download_ForPurchaseOnly]    Script Date: 05/16/2009 13:24:30 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_dashCommerce_Store_Download_ForPurchaseOnly]') AND parent_object_id = OBJECT_ID(N'[dbo].[dashCommerce_Store_Download]'))
Begin
ALTER TABLE [dbo].[dashCommerce_Store_Download] ADD  CONSTRAINT [DF_dashCommerce_Store_Download_ForPurchaseOnly]  DEFAULT ((1)) FOR [ForPurchaseOnly]

End
GO
/****** Object:  Default [DF_dashCommerce_Store_Download_CreatedOn]    Script Date: 05/16/2009 13:24:30 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_dashCommerce_Store_Download_CreatedOn]') AND parent_object_id = OBJECT_ID(N'[dbo].[dashCommerce_Store_Download]'))
Begin
ALTER TABLE [dbo].[dashCommerce_Store_Download] ADD  CONSTRAINT [DF_dashCommerce_Store_Download_CreatedOn]  DEFAULT (getutcdate()) FOR [CreatedOn]

End
GO
/****** Object:  Default [DF_dashCommerce_Store_Download_ModifiedOn]    Script Date: 05/16/2009 13:24:30 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_dashCommerce_Store_Download_ModifiedOn]') AND parent_object_id = OBJECT_ID(N'[dbo].[dashCommerce_Store_Download]'))
Begin
ALTER TABLE [dbo].[dashCommerce_Store_Download] ADD  CONSTRAINT [DF_dashCommerce_Store_Download_ModifiedOn]  DEFAULT (getutcdate()) FOR [ModifiedOn]

End
GO
/****** Object:  ForeignKey [FK_dashCommerce_Store_DownloadAccessControl_aspnet_Users]    Script Date: 05/16/2009 13:24:30 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dashCommerce_Store_DownloadAccessControl_aspnet_Users]') AND parent_object_id = OBJECT_ID(N'[dbo].[dashCommerce_Store_DownloadAccessControl]'))
ALTER TABLE [dbo].[dashCommerce_Store_DownloadAccessControl]  WITH CHECK ADD  CONSTRAINT [FK_dashCommerce_Store_DownloadAccessControl_aspnet_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[aspnet_Users] ([UserId])
GO
ALTER TABLE [dbo].[dashCommerce_Store_DownloadAccessControl] CHECK CONSTRAINT [FK_dashCommerce_Store_DownloadAccessControl_aspnet_Users]
GO
/****** Object:  ForeignKey [FK_dashCommerce_Store_DownloadAccessControl_dashCommerce_Store_Download]    Script Date: 05/16/2009 13:24:30 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dashCommerce_Store_DownloadAccessControl_dashCommerce_Store_Download]') AND parent_object_id = OBJECT_ID(N'[dbo].[dashCommerce_Store_DownloadAccessControl]'))
ALTER TABLE [dbo].[dashCommerce_Store_DownloadAccessControl]  WITH CHECK ADD  CONSTRAINT [FK_dashCommerce_Store_DownloadAccessControl_dashCommerce_Store_Download] FOREIGN KEY([DownloadId])
REFERENCES [dbo].[dashCommerce_Store_Download] ([DownloadId])
GO
ALTER TABLE [dbo].[dashCommerce_Store_DownloadAccessControl] CHECK CONSTRAINT [FK_dashCommerce_Store_DownloadAccessControl_dashCommerce_Store_Download]
GO
/****** Object:  Table [dbo].[dashCommerce_Store_Product_Download_Map]    Script Date: 05/17/2009 13:57:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dashCommerce_Store_Product_Download_Map](
	[ProductId] [int] NOT NULL,
	[DownloadId] [int] NOT NULL,
 CONSTRAINT [PK_dashCommerce_Store_Product_Download_Map] PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC,
	[DownloadId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[dashCommerce_Store_Product_Download_Map]  WITH CHECK ADD  CONSTRAINT [FK_dashCommerce_Store_Product_Download_Map_dashCommerce_Store_Download] FOREIGN KEY([DownloadId])
REFERENCES [dbo].[dashCommerce_Store_Download] ([DownloadId])
GO
ALTER TABLE [dbo].[dashCommerce_Store_Product_Download_Map] CHECK CONSTRAINT [FK_dashCommerce_Store_Product_Download_Map_dashCommerce_Store_Download]
GO
ALTER TABLE [dbo].[dashCommerce_Store_Product_Download_Map]  WITH CHECK ADD  CONSTRAINT [FK_dashCommerce_Store_Product_Download_Map_dashCommerce_Store_Product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[dashCommerce_Store_Product] ([ProductId])
GO
ALTER TABLE [dbo].[dashCommerce_Store_Product_Download_Map] CHECK CONSTRAINT [FK_dashCommerce_Store_Product_Download_Map_dashCommerce_Store_Product]
/****** Object:  StoredProcedure [dbo].[dashCommerce_Store_FetchAvailableDownloadsByProductId]    Script Date: 05/17/2009 14:03:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================================
-- Licensed Under the dashCommerce License 
-- http://dashcommerce.org/dashCommerce/license.aspx
-- Copyright (c) 2007 - 2008 Mettle Systems LLC, P.O. Box 181192 
-- Cleveland Heights, Ohio 44118, United States
-- ================================================================

CREATE PROCEDURE [dbo].[dashCommerce_Store_FetchAvailableDownloadsByProductId]
	@ProductId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT dashCommerce_Store_Download.*
	FROM dashCommerce_Store_Download
	WHERE DownloadId NOT IN 
	(SELECT DownloadId FROM dashCommerce_Store_Product_Download_Map WHERE ProductId = @ProductId)
	ORDER BY [Title]
END
GO
/****** Object:  StoredProcedure [dbo].[dashCommerce_Store_FetchAssociatedDownloadsByProductId]    Script Date: 05/17/2009 14:06:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================================
-- Licensed Under the dashCommerce License 
-- http://dashcommerce.org/dashCommerce/license.aspx
-- Copyright (c) 2007 - 2008 Mettle Systems LLC, P.O. Box 181192 
-- Cleveland Heights, Ohio 44118, United States
-- ================================================================

CREATE PROCEDURE [dbo].[dashCommerce_Store_FetchAssociatedDownloadsByProductId]
  @ProductId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT 
		dbo.dashCommerce_Store_Download.*
	FROM
		dbo.dashCommerce_Store_Product_Download_Map 
		INNER JOIN dbo.dashCommerce_Store_Download 
		ON dbo.dashCommerce_Store_Product_Download_Map.DownloadId = dbo.dashCommerce_Store_Download.DownloadId
	WHERE dashCommerce_Store_Product_Download_Map.ProductId = @ProductId
END
GO
/****** Object:  StoredProcedure [dbo].[dashCommerce_Store_FetchAssociatedDownloadsByProductIdAndForPurchase]    Script Date: 05/17/2009 14:07:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================================
-- Licensed Under the dashCommerce License 
-- http://dashcommerce.org/dashCommerce/license.aspx
-- Copyright (c) 2007 - 2008 Mettle Systems LLC, P.O. Box 181192 
-- Cleveland Heights, Ohio 44118, United States
-- ================================================================

CREATE PROCEDURE [dbo].[dashCommerce_Store_FetchAssociatedDownloadsByProductIdAndForPurchase]
  @ProductId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT 
		dbo.dashCommerce_Store_Download.*
	FROM
		dbo.dashCommerce_Store_Product_Download_Map 
		INNER JOIN dbo.dashCommerce_Store_Download 
		ON dbo.dashCommerce_Store_Product_Download_Map.DownloadId = dbo.dashCommerce_Store_Download.DownloadId
	WHERE dashCommerce_Store_Product_Download_Map.ProductId = @ProductId AND dashCommerce_Store_Download.ForPurchaseOnly = 1
END
GO
/****** Object:  StoredProcedure [dbo].[dashCommerce_Store_FetchAssociatedDownloadsByProductIdAndNotForPurchase]    Script Date: 05/17/2009 14:08:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================================
-- Licensed Under the dashCommerce License 
-- http://dashcommerce.org/dashCommerce/license.aspx
-- Copyright (c) 2007 - 2008 Mettle Systems LLC, P.O. Box 181192 
-- Cleveland Heights, Ohio 44118, United States
-- ================================================================

CREATE PROCEDURE [dbo].[dashCommerce_Store_FetchAssociatedDownloadsByProductIdAndNotForPurchase]
  @ProductId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT 
		dbo.dashCommerce_Store_Download.*
	FROM
		dbo.dashCommerce_Store_Product_Download_Map 
		INNER JOIN dbo.dashCommerce_Store_Download 
		ON dbo.dashCommerce_Store_Product_Download_Map.DownloadId = dbo.dashCommerce_Store_Download.DownloadId
	WHERE dashCommerce_Store_Product_Download_Map.ProductId = @ProductId AND dashCommerce_Store_Download.ForPurchaseOnly = 0
END
GO
/****** Object:  StoredProcedure [dbo].[dashCommerce_Store_FetchPurchasedDownloadsByUserId]    Script Date: 05/17/2009 15:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================================
-- Licensed Under the dashCommerce License 
-- http://dashcommerce.org/dashCommerce/license.aspx
-- Copyright (c) 2007 - 2008 Mettle Systems LLC, P.O. Box 181192 
-- Cleveland Heights, Ohio 44118, United States
-- ================================================================

CREATE PROCEDURE [dbo].[dashCommerce_Store_FetchPurchasedDownloadsByUserId] 
  @UserId uniqueidentifier	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

  -- Insert statements for procedure here
	SELECT * 
  FROM dashCommerce_Store_Download
  WHERE dashCommerce_Store_Download.DownloadId 
  IN (SELECT DownloadId FROM dashCommerce_Store_DownloadAccessControl WHERE UserId = @UserId)
END
GO
/****** Object:  StoredProcedure [dbo].[dashCommerce_Store_ProductSearch]    Script Date: 05/23/2009 14:56:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================================
-- Licensed Under the dashCommerce License 
-- http://dashcommerce.org/dashCommerce/license.aspx
-- Copyright (c) 2007 - 2008 Mettle Systems LLC, P.O. Box 181192 
-- Cleveland Heights, Ohio 44118, United States
-- ================================================================

ALTER PROCEDURE [dbo].[dashCommerce_Store_ProductSearch]
  @searchTerm nvarchar(100)
AS 
  BEGIN
    SET NOCOUNT ON

    SELECT *
    FROM dashCommerce_Store_Product
    WHERE
    IsEnabled = 1 AND ProductStatusDescriptorId <> 99 AND ( 
    FREETEXT([Name], @searchTerm)
    OR
    FREETEXT([ShortDescription], @searchTerm)
    OR
    FREETEXT([BaseSku], @searchTerm))
    
  END
GO
/****** Object:  Table [dbo].[dashCommerce_Store_Version]    Script Date: 05/16/2009 13:45:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dashCommerce_Store_Version]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[dashCommerce_Store_Version](
	[VersionId] [int] IDENTITY(1,1) NOT NULL,
	[Major] [int] NOT NULL,
	[Minor] [int] NOT NULL,
	[Build] [int] NOT NULL,
	[Revision] [int] NOT NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NOT NULL CONSTRAINT [DF_dashCommerce_Store_Version_CreatedOn] DEFAULT (getutcdate()),
	[ModifiedBy] [nvarchar](50) NULL,
	[ModifiedOn] [datetime] NOT NULL CONSTRAINT [DF_dashCommerce_Store_Version_ModifiedOn] DEFAULT (getutcdate()),
 CONSTRAINT [PK_dashCommerce_Store_Version] PRIMARY KEY CLUSTERED 
(
	[VersionId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
)
END
SET IDENTITY_INSERT [dbo].[dashCommerce_Store_Version] ON
INSERT [dbo].[dashCommerce_Store_Version] ([VersionId], [Major], [Minor], [Build], [Revision], [CreatedBy], [ModifiedBy]) VALUES (1, 3, 2, 0, 0, N'SYSTEM', N'SYSTEM')
SET IDENTITY_INSERT [dbo].[dashCommerce_Store_Version] OFF

-- END PK and FK Mod Tables
-- START STAND ALONE Tables
PRINT N'Creating [dbo].[dashCommerce_Store_SimpleWeightShippingRate]'
GO
CREATE TABLE [dbo].[dashCommerce_Store_SimpleWeightShippingRate]
(
[SimpleWeightShippingRateId] [int] NOT NULL IDENTITY(1, 1),
[Service] [varchar] (50) NOT NULL,
[AmountPerUnit] [money] NOT NULL,
[CreatedBy] [nvarchar] (50) NULL,
[CreatedOn] [datetime] NOT NULL CONSTRAINT [DF_dashCommerce_Shipping_Rate_createdOn] DEFAULT (getutcdate()),
[ModifiedBy] [nvarchar] (50) NULL,
[ModifiedOn] [datetime] NOT NULL CONSTRAINT [DF_dashCommerce_Shipping_Rate_modifiedOn] DEFAULT (getutcdate())
) ON [PRIMARY]
SET IDENTITY_INSERT [dbo].[dashCommerce_Store_SimpleWeightShippingRate] ON
INSERT INTO [dbo].[dashCommerce_Store_SimpleWeightShippingRate]([SimpleWeightShippingRateId], [Service], [AmountPerUnit], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) SELECT [ShippingRateId], [Service], [AmountPerUnit], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn] FROM [dbo].[dashCommerce_Store_SimpleWeight_Shipping_Rate]
SET IDENTITY_INSERT [dbo].[dashCommerce_Store_SimpleWeightShippingRate] OFF
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_dashCommerce_ShippingRates] on [dbo].[dashCommerce_Store_SimpleWeightShippingRate]'
GO
ALTER TABLE [dbo].[dashCommerce_Store_SimpleWeightShippingRate] ADD CONSTRAINT [PK_dashCommerce_ShippingRates] PRIMARY KEY CLUSTERED  ([SimpleWeightShippingRateId]) ON [PRIMARY]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[dashCommerce_Store_SimpleWeight_Shipping_Rate]'
GO
DROP TABLE [dbo].[dashCommerce_Store_SimpleWeight_Shipping_Rate]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Rebuilding [dbo].[dashCommerce_Core_Log]'
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
SET XACT_ABORT ON
GO
BEGIN TRANSACTION
CREATE TABLE [dbo].[tmp_ms_xx_dashCommerce_Core_Log]
(
[LogId] [int] NOT NULL IDENTITY(1, 1),
[LogDate] [datetime] NOT NULL CONSTRAINT [DF_Script_Message_Log_Log_Date] DEFAULT (getutcdate()),
[Message] [text] NULL,
[MessageType] [tinyint] NOT NULL,
[UserAgent] [nvarchar] (256) NULL,
[RemoteHost] [nvarchar] (256) NULL,
[AuthUser] [nvarchar] (64) NULL,
[Referer] [nvarchar] (512) NULL,
[MachineName] [nvarchar] (32) NULL,
[FormData] [text] NULL,
[QueryStringData] [nvarchar] (512) NULL,
[CookiesData] [nvarchar] (2048) NULL,
[ExceptionType] [nvarchar] (256) NULL,
[ScriptName] [nvarchar] (256) NULL,
[ExceptionMessage] [nvarchar] (512) NULL,
[ExceptionSource] [nvarchar] (256) NULL,
[ExceptionStackTrace] [nvarchar] (2048) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
--SET IDENTITY_INSERT [dbo].[tmp_ms_xx_dashCommerce_Core_Log] ON
--INSERT INTO [dbo].[tmp_ms_xx_dashCommerce_Core_Log]([LogId], [LogDate], [AmountPerUnit], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) SELECT [ShippingRateId], [Service], [AmountPerUnit], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn] FROM [dbo].[dashCommerce_Store_SimpleWeight_Shipping_Rate]
--SET IDENTITY_INSERT [dbo].[tmp_ms_xx_dashCommerce_Core_Log] OFF
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[dashCommerce_Core_Log]'
GO
DROP TABLE [dbo].[dashCommerce_Core_Log]
EXEC sp_rename N'[dbo].[tmp_ms_xx_dashCommerce_Core_Log]', N'dashCommerce_Core_Log'
COMMIT TRANSACTION
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[dashCommerce_Store_RegionCodeTaxRate]'
GO
CREATE TABLE [dbo].[dashCommerce_Store_RegionCodeTaxRate]
(
[RegionCodeTaxRateId] [int] NOT NULL IDENTITY(1, 1),
[Rate] [money] NOT NULL,
[RegionCode] [nvarchar] (50) NOT NULL,
[CreatedBy] [nvarchar] (50) NULL,
[CreatedOn] [datetime] NOT NULL CONSTRAINT [DF_dashCommerce_Tax_Rate_createdOn] DEFAULT (getutcdate()),
[ModifiedBy] [nvarchar] (50) NULL,
[ModifiedOn] [datetime] NOT NULL CONSTRAINT [DF_dashCommerce_Tax_Rate_modifiedOn] DEFAULT (getutcdate())
) ON [PRIMARY]
SET IDENTITY_INSERT [dbo].[dashCommerce_Store_RegionCodeTaxRate] ON
INSERT INTO [dbo].[dashCommerce_Store_RegionCodeTaxRate]([RegionCodeTaxRateId], [Rate], [RegionCode], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) SELECT [RateId], [Rate], [RegionCode], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn] FROM [dbo].[dashCommerce_Store_RegionCode_Tax_Rate]
SET IDENTITY_INSERT [dbo].[dashCommerce_Store_RegionCodeTaxRate] OFF
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[dashCommerce_Store_RegionCode_Tax_Rate]'
GO
DROP TABLE [dbo].[dashCommerce_Store_RegionCode_Tax_Rate]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_dashCommerce_Taxes] on [dbo].[dashCommerce_Store_RegionCodeTaxRate]'
GO
ALTER TABLE [dbo].[dashCommerce_Store_RegionCodeTaxRate] ADD CONSTRAINT [PK_dashCommerce_Taxes] PRIMARY KEY CLUSTERED  ([RegionCodeTaxRateId]) ON [PRIMARY]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Rebuilding [dbo].[dashCommerce_Store_ProductRating]'
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
SET XACT_ABORT ON
GO
BEGIN TRANSACTION
CREATE TABLE [dbo].[tmp_ms_xx_dashCommerce_Store_ProductRating]
(
[ProductRatingId] [int] NOT NULL IDENTITY(1, 1),
[ProductId] [int] NOT NULL,
[UserName] [nvarchar] (256) NOT NULL,
[Rating] [int] NOT NULL,
[CreatedBy] [nvarchar] (50) NULL,
[CreatedOn] [datetime] NOT NULL CONSTRAINT [DF_dashCommerce_Store_Rating_createdOn] DEFAULT (getutcdate()),
[ModifiedBy] [nvarchar] (50) NULL,
[ModifiedOn] [datetime] NOT NULL CONSTRAINT [DF_dashCommerce_Store_Rating_modifiedOn] DEFAULT (getutcdate())
) ON [PRIMARY]
SET IDENTITY_INSERT [dbo].[tmp_ms_xx_dashCommerce_Store_ProductRating] ON
INSERT INTO [dbo].[tmp_ms_xx_dashCommerce_Store_ProductRating]([ProductRatingId], [ProductId], [UserName], [Rating], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) SELECT [RatingId], [ProductId], [UserName], [Rating], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn] FROM [dbo].[dashCommerce_Store_ProductRating]
SET IDENTITY_INSERT [dbo].[tmp_ms_xx_dashCommerce_Store_ProductRating] OFF
DROP TABLE [dbo].[dashCommerce_Store_ProductRating]
EXEC sp_rename N'[dbo].[tmp_ms_xx_dashCommerce_Store_ProductRating]', N'dashCommerce_Store_ProductRating'
COMMIT TRANSACTION
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
GO
PRINT N'Creating primary key [PK_dashCommerce_ProductRating] on [dbo].[dashCommerce_Store_ProductRating]'
GO
ALTER TABLE [dbo].[dashCommerce_Store_ProductRating] ADD CONSTRAINT [PK_dashCommerce_ProductRating] PRIMARY KEY CLUSTERED  ([ProductRatingId]) ON [PRIMARY]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[dashCommerce_Store_FetchCategoryPriceRanges]'
GO
-- ================================================================
-- Licensed Under the dashCommerce License 
-- http://dashcommerce.org/dashCommerce/license.aspx
-- Copyright (c) 2007 - 2008 Mettle Systems LLC, P.O. Box 181192 
-- Cleveland Heights, Ohio 44118, United States
-- ================================================================

ALTER PROCEDURE [dbo].[dashCommerce_Store_FetchCategoryPriceRanges] 
	@CategoryId int	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @MinPrice money, @MaxPrice money
	
	SELECT  @MinPrice = MIN(ourPrice)
		     ,@MaxPrice = MAX(ourPrice)
	FROM dashCommerce_Store_Product 
	WHERE ProductId IN 
		(SELECT ProductId 
		 FROM dashCommerce_Store_Product_Category_Map 
		 WHERE CategoryId IN (SELECT CategoryId FROM dbo.CategoryHierarchy(@CategoryId))
	)
	CREATE TABLE #prices(lowRange money, hiRange money)
	DECLARE @thisLow money, @thisHigh money
	SET @thisLow = @minPrice
	SET @thisHigh = 2 * @thisLow - .01
	IF @thisLow = 0
	BEGIN
		SET @thisHigh = 1
	END	

	DECLARE @loopCatch int
	
	--catch infinite loops
	SELECT @loopCatch = 1
	WHILE @thisLow <= @maxPrice AND @loopCatch < 100
		BEGIN
			INSERT INTO #prices(lowRange, hiRange) VALUES (@thisLow, @thisHigh)
			SET @thisLow = @thisHigh + .01
			SET @thisHigh = 2 * @thisLow - .01
			SELECT @loopCatch = @loopCatch + 1
		END
	SELECT * FROM #prices
	DROP TABLE #prices
END
GO
/****** Object:  View [dbo].[vw_dashCommerce_NotInActiveAndLocked_Products]    Script Date: 05/16/2009 15:17:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER VIEW [dbo].[vw_dashCommerce_NotInActiveAndLocked_Products]
AS
SELECT     ProductId, ManufacturerId, ProductStatusDescriptorId, ProductTypeId, ShippingEstimateId, BaseSku, ProductGuid, Name, ShortDescription, OurPrice, 
                      RetailPrice, Weight, Length, Height, Width, SortOrder, RatingSum, TotalRatingVotes, AllowNegativeInventories, IsEnabled, CreatedBy, CreatedOn, 
                      ModifiedBy, ModifiedOn, IsDeleted
FROM         dbo.dashCommerce_Store_Product
WHERE     (IsEnabled = 1) AND (IsDeleted = 0) AND (ProductStatusDescriptorId <> 99)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
/****** Object:  StoredProcedure [dbo].[dashCommerce_Store_FetchMostPopularProducts]    Script Date: 05/16/2009 15:10:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================================
-- Licensed Under the dashCommerce License 
-- http://dashcommerce.org/dashCommerce/license.aspx
-- Copyright (c) 2007 - 2008 Mettle Systems LLC, P.O. Box 181192 
-- Cleveland Heights, Ohio 44118, United States
-- ================================================================

ALTER PROCEDURE [dbo].[dashCommerce_Store_FetchMostPopularProducts]
  @BrowsingBehviorId int 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    SELECT TOP 6 
        v.*
       ,COUNT(dashCommerce_Store_Browsing_Log.BrowsingLogId) AS ViewCount 
    FROM dashCommerce_Store_Browsing_Log 
    INNER JOIN vw_dashCommerce_NotInActiveAndLocked_Products v 
    ON dashCommerce_Store_Browsing_Log.RelevantId = v.ProductId
    WHERE dashCommerce_Store_Browsing_Log.BrowsingBehaviorId = @BrowsingBehviorId
    GROUP BY 
        v.ProductId
       ,v.ManufacturerId
       ,v.ProductStatusDescriptorId
       ,v.ProductTypeId
       ,v.ShippingEstimateId
       ,v.BaseSku
       ,v.ProductGuid
       ,v.[Name]
       ,v.ShortDescription
       ,v.OurPrice
       ,v.RetailPrice
       ,v.Weight
       ,v.Length
       ,v.Height
       ,v.Width
       ,v.SortOrder
       ,v.RatingSum
       ,v.TotalRatingVotes
       ,v.IsEnabled
       ,v.AllowNegativeInventories
       ,v.CreatedBy
       ,v.CreatedOn
       ,v.ModifiedBy
       ,v.ModifiedOn
       ,v.IsDeleted
    ORDER BY ViewCount DESC
END
GO
PRINT N'Adding foreign keys to [dbo].[dashCommerce_Store_Order]'
GO
ALTER TABLE [dbo].[dashCommerce_Store_Order] WITH NOCHECK ADD
CONSTRAINT [FK_dashCommerce_Store_Order_dashCommerce_Store_OrderStatusDescriptor] FOREIGN KEY ([OrderStatusDescriptorId]) REFERENCES [dbo].[dashCommerce_Store_OrderStatusDescriptor] ([OrderStatusDescriptorId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[dashCommerce_Store_OrderNote]'
GO
ALTER TABLE [dbo].[dashCommerce_Store_OrderNote] WITH NOCHECK ADD
CONSTRAINT [FK_dashCommerce_Store_OrderNote_dashCommerce_Store_Order] FOREIGN KEY ([OrderId]) REFERENCES [dbo].[dashCommerce_Store_Order] ([OrderId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[dashCommerce_Store_Product]'
GO
ALTER TABLE [dbo].[dashCommerce_Store_Product] WITH NOCHECK ADD
CONSTRAINT [FK_dashCommerce_Products_dashCommerce_ProductStatus] FOREIGN KEY ([ProductStatusDescriptorId]) REFERENCES [dbo].[dashCommerce_Store_ProductStatusDescriptor] ([ProductStatusDescriptorId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[dashCommerce_Store_Transaction]'
GO
ALTER TABLE [dbo].[dashCommerce_Store_Transaction] WITH NOCHECK ADD
CONSTRAINT [FK_dashCommerce_OrderTransactions_dashCommerce_OrderTransactionTypes] FOREIGN KEY ([TransactionTypeDescriptorId]) REFERENCES [dbo].[dashCommerce_Store_TransactionTypeDescriptor] ([TransactionTypeDescriptorId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[dashCommerce_Store_CustomizedProductDisplayType_Product_Map]'
GO
ALTER TABLE [dbo].[dashCommerce_Store_CustomizedProductDisplayType_Product_Map] ADD
CONSTRAINT [FK_dashCommerce_Store_CustomizedProductDisplayType_Product_Map_dashCommerce_Store_CustomizedProductDisplayTypes] FOREIGN KEY ([CustomizedProductDisplayTypeId]) REFERENCES [dbo].[dashCommerce_Store_CustomizedProductDisplayType] ([CustomizedProductDisplayTypeId]),
CONSTRAINT [FK_CustomizedProductsDisplayType_Product_Map_dashCommerce_Store_Product] FOREIGN KEY ([ProductId]) REFERENCES [dbo].[dashCommerce_Store_Product] ([ProductId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
IF NOT EXISTS (SELECT [Name] FROM [dashCommerce_Content_Provider] WHERE [Name] =N'Contact Us')
INSERT [dbo].[dashCommerce_Content_Provider] ([Name], [ViewControl], [EditControl], [StyleSheet], [CreatedBy], [ModifiedBy]) VALUES (N'Contact Us', N'~/controls/content/ContactUs.ascx', '~/admin/controls/content/EditContactUs.ascx', NULL, N'SYSTEM', N'SYSTEM')
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
IF EXISTS (SELECT * FROM #tmpErrors) ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT>0 BEGIN
PRINT 'The database update succeeded'
COMMIT TRANSACTION
END
ELSE PRINT 'The database update failed'
GO
DROP TABLE #tmpErrors
GO
