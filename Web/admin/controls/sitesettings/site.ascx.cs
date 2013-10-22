#region dashCommerce License
/*
dashCommerce� is Copyright � 2008-2012 Mettle Systems LLC. All Rights Reserved.


dashCommerce, and the dashCommerce logo are registered trademarks of Mettle Systems LLC. Mettle Systems LLC logos and trademarks may not be used without prior written consent.

dashCommerce is licensed under the following license. If you do not accept the terms, please discontinue the use of dashCommerce and uninstall dashCommerce. 

Your license to the dashCommerce source and/or binaries is governed by the Reciprocal Public License 1.5 (RPL1.5) license as described here: 

http://www.opensource.org/licenses/rpl1.5.txt 

If you do not wish to release the source of software you build using dashCommerce, you may purchase a site license, which will allow you to deploy dashCommerce for use in 1 web store defined as using 1 URL. You may purchase a site license here: 

http://www.dashcommerce.org/license.html 
*/
#endregion
using System;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;
using MettleSystems.dashCommerce.Core;
using MettleSystems.dashCommerce.Localization;
using MettleSystems.dashCommerce.Store;

namespace MettleSystems.dashCommerce.Web.admin.controls.sitesettings {
  public partial class site : SiteSettingsControl {


    #region Page Events

    /// <summary>
    /// Handles the Load event of the Page control.
    /// </summary>
    /// <param name="sender">The source of the event.</param>
    /// <param name="e">The <see cref="T:System.EventArgs"/> instance containing the event data.</param>
    protected override void Page_Load(object sender, EventArgs e) {
      try {
        base.Page_Load(sender, e);
        if (string.IsNullOrEmpty(view) || view.Equals("s")) {//since it is default view
          SetGeneralSettingsProperties();
          if (!Page.IsPostBack) {
            SetLoginRequirement();
            SetNumberOfItemsDropDown();
            SetDefaultSoringDropDown();
            SetThemeSelections();
            chkStoreClosed.Checked = SiteSettings.IsStoreClosed;
            txtLogo.Text = SiteSettings.SiteLogo;//SiteSettings.Site.Logo == null ? SiteSettings.SiteLogo : SiteSettings.Site.Logo;
            ddlCategoryItems.SelectedValue = SiteSettings.CatalogItems.ToString();
            ddlTheme.SelectedValue = SiteSettings.Theme;
            ddlLoginRequirement.SelectedValue = Enum.GetName(typeof(LoginRequirement), SiteSettings.LoginRequirement);
            txtName.Text = SiteSettings.SiteName;
            txtTagLine.Text = SiteSettings.TagLine;
            chkRequireSsl.Checked = SiteSettings.RequireSsl;
            txtMaximumProductsToAddToCart.Text = SiteSettings.MaxProductsAddToCart.ToString();
            txtNewsFeedUrl.Text = SiteSettings.NewsFeedUrl;
            chkDisplayRetailPrice.Checked = SiteSettings.DisplayRetailPrice;
            chkAddTaxToPrice.Checked = SiteSettings.AddTaxToPrice;
            ddlDefaultSort.SelectedValue = SiteSettings.DefaultCatalogSort.ToString();
            chkDisplayRatings.Checked = SiteSettings.DisplayRatings;
            chkDisplayShippingOnCart.Checked = SiteSettings.DisplayShippingOnCart;
          }
        }
      }
      catch (Exception ex) {
        Logger.Error(typeof(site).Name + ".Page_Load", ex);
        base.MasterPage.MessageCenter.DisplayCriticalMessage(ex.Message);
      }
    }

    /// <summary>
    /// Handles the Click event of the btnSave control.
    /// </summary>
    /// <param name="sender">The source of the event.</param>
    /// <param name="e">The <see cref="T:System.EventArgs"/> instance containing the event data.</param>
    protected void btnSave_Click(object sender, EventArgs e) {
      try {
        SiteSettings.IsStoreClosed = chkStoreClosed.Checked;
        SiteSettings.SiteLogo = txtLogo.Text;
        SiteSettings.Theme = ddlTheme.SelectedValue;
        SiteSettings.SiteName = txtName.Text.Trim();
        SiteSettings.TagLine = txtTagLine.Text.Trim();
        SiteSettings.LoginRequirement = (LoginRequirement)Enum.Parse(typeof(LoginRequirement), ddlLoginRequirement.SelectedValue);
        SiteSettings.RequireSsl = chkRequireSsl.Checked;
        int catalogItems = 6;
        int.TryParse(ddlCategoryItems.SelectedValue, out catalogItems);
        int maxProductsToAddToCart = 0;
        if (int.TryParse(txtMaximumProductsToAddToCart.Text, out maxProductsToAddToCart)) {
          SiteSettings.MaxProductsAddToCart = maxProductsToAddToCart;
        }
        SiteSettings.CatalogItems = catalogItems;
        SiteSettings.DisplayRetailPrice = chkDisplayRetailPrice.Checked;
        SiteSettings.AddTaxToPrice = chkAddTaxToPrice.Checked;
        SiteSettings.NewsFeedUrl = txtNewsFeedUrl.Text;
        SiteSettings.DefaultCatalogSort = Int32.Parse(ddlDefaultSort.SelectedValue);
        SiteSettings.DisplayRatings = chkDisplayRatings.Checked;
        SiteSettings.DisplayShippingOnCart = chkDisplayShippingOnCart.Checked;
        base.Save(SiteSettings);
      }
      catch (Exception ex) {
        Logger.Error(typeof(site).Name + ".btnSave_Click", ex);
        base.MasterPage.MessageCenter.DisplayCriticalMessage(ex.Message);
      }
    }

    #endregion

    #region Methods

    #region Private

    /// <summary>
    /// Sets the theme selections.
    /// </summary>
    private void SetThemeSelections() {
      string[] themes = Directory.GetDirectories(Server.MapPath("~/App_Themes"));
      string path = string.Empty;
      for (int i = 0; i < themes.Length; i++) {
        themes[i] = new DirectoryInfo(themes[i]).Name;
      }
      ddlTheme.DataSource = themes;
      ddlTheme.DataBind();
    }

    /// <summary>
    /// Sets the number of items drop down.
    /// </summary>
    private void SetNumberOfItemsDropDown() {
      for(int i = 1; i <= 100; i++) {
        ddlCategoryItems.Items.Add(new ListItem(i.ToString(), i.ToString()));
      }
    }

    /// <summary>
    /// Sets the login requirement.
    /// </summary>
    private void SetLoginRequirement() {
      string[] names = Enum.GetNames(typeof(LoginRequirement));
      ddlLoginRequirement.DataSource = names;
      ddlLoginRequirement.DataBind(); 
    }
    
    private void SetDefaultSoringDropDown() {
      ddlDefaultSort.Items.Add(new ListItem(LocalizationUtility.GetText("lblNone"), "0"));
      ddlDefaultSort.Items.Add(new ListItem(LocalizationUtility.GetText("lblPriceASC"), "1"));
      ddlDefaultSort.Items.Add(new ListItem(LocalizationUtility.GetText("lblPriceDESC"), "2"));
      ddlDefaultSort.Items.Add(new ListItem(LocalizationUtility.GetText("lblNewest"), "3"));
      ddlDefaultSort.Items.Add(new ListItem(LocalizationUtility.GetText("lblOldest"), "4"));
      ddlDefaultSort.Items.Add(new ListItem(LocalizationUtility.GetText("lblLastUpdatedASC"), "5"));
      ddlDefaultSort.Items.Add(new ListItem(LocalizationUtility.GetText("lblLastUpdatedDESC"), "6"));
      ddlDefaultSort.Items.Add(new ListItem(LocalizationUtility.GetText("lblTitleASC"), "7"));
      ddlDefaultSort.Items.Add(new ListItem(LocalizationUtility.GetText("lblTitleDESC"), "8"));
    }

    /// <summary>
    /// Sets the general settings properties.
    /// </summary>
    private void SetGeneralSettingsProperties() {
      this.Page.Title = LocalizationUtility.GetText("titleSiteSettingsGeneralLayout");
      hlImageSelector.NavigateUrl = string.Format("~/admin/imageselector.aspx?view=s&controlId={0}", txtLogo.ClientID);
    }

    #endregion

    #endregion

  }
}