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
using System.Web;
using System.Web.UI;

using MettleSystems.dashCommerce.Core;
using MettleSystems.dashCommerce.Localization;
using MettleSystems.dashCommerce.Store.Services;
using MettleSystems.dashCommerce.Store.Services.PaymentService;
using MettleSystems.dashCommerce.Store.Web.Controls;

namespace MettleSystems.dashCommerce.Web.admin.controls.configuration.paymentproviders {
  public partial class paypalproconfiguration : PaymentConfigurationControl {

    #region Member Variables
    
    ProviderSettings payPalProConfigurationSettings = null;
    PaymentServiceSettings paymentServiceSettings;
    
    #endregion
    
    #region Page Events

    /// <summary>
    /// Handles the Load event of the Page control.
    /// </summary>
    /// <param name="sender">The source of the event.</param>
    /// <param name="e">The <see cref="T:System.EventArgs"/> instance containing the event data.</param>
    protected void Page_Load(object sender, EventArgs e) {
      try {
        SetPayPalProConfigurationProperties();
        paymentServiceSettings = PaymentService.FetchConfiguredPaymentProviders();
        if(paymentServiceSettings != null) {
          foreach(ProviderSettings providerSettings in paymentServiceSettings.ProviderSettingsCollection) {
            if(providerSettings.Name == typeof(PayPalProPaymentProvider).Name) {
              payPalProConfigurationSettings = providerSettings;
              break;
            }
          }
          if(payPalProConfigurationSettings != null) {
            txtApiUserName.Text = payPalProConfigurationSettings.Parameters[PayPalProPaymentProvider.API_USERNAME];
            txtApiPassword.Text = payPalProConfigurationSettings.Parameters[PayPalProPaymentProvider.API_PASSWORD];
            txtSignature.Text = payPalProConfigurationSettings.Parameters[PayPalProPaymentProvider.SIGNATURE];
            bool isLive = false;
            bool isParsed = bool.TryParse(payPalProConfigurationSettings.Parameters[PayPalProPaymentProvider.ISLIVE], out isLive);
            chkIsLive.Checked = isLive;
          }
        }
        else {
          paymentServiceSettings = new PaymentServiceSettings();
        }
      }
      catch(Exception ex) {
        Logger.Error(typeof(paypalproconfiguration).Name + ".Page_Load", ex);
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
        if (payPalProConfigurationSettings == null) {
          payPalProConfigurationSettings = new ProviderSettings(typeof(PayPalProPaymentProvider).Name, typeof(PayPalProPaymentProvider).AssemblyQualifiedName);
          paymentServiceSettings.ProviderSettingsCollection.Add(payPalProConfigurationSettings);
        }
        payPalProConfigurationSettings.Parameters.Clear();
        //IMPORTANT: These need to be added in the order they are expected by the constructor used by
        //Activator.CreateInstance in PaymentService
        payPalProConfigurationSettings.Parameters.Add(PayPalProPaymentProvider.API_USERNAME, txtApiUserName.Text.Trim());
        payPalProConfigurationSettings.Parameters.Add(PayPalProPaymentProvider.API_PASSWORD, txtApiPassword.Text.Trim());
        payPalProConfigurationSettings.Parameters.Add(PayPalProPaymentProvider.SIGNATURE, txtSignature.Text.Trim());
        //payPalProConfigurationSettings.Parameters.Add(PayPalProPaymentProvider.BUSINESS_EMAIL, string.Empty);
        payPalProConfigurationSettings.Parameters.Add(PayPalProPaymentProvider.ISLIVE, chkIsLive.Checked.ToString());
        int id = base.Save(paymentServiceSettings, WebUtility.GetUserName());
        if (id > 0) {
          MasterPage.MessageCenter.DisplaySuccessMessage(LocalizationUtility.GetText("lblPaymentConfigurationSaved"));
        }
        else {
          MasterPage.MessageCenter.DisplayFailureMessage(LocalizationUtility.GetText("lblPaymentConfigurationNotSaved"));
        }
      }
      catch(Exception ex) {
        Logger.Error(typeof(paypalproconfiguration).Name + ".btnSave_Click", ex);
        base.MasterPage.MessageCenter.DisplayCriticalMessage(ex.Message);
      }     
    }
    
    #endregion
    
    #region Methods
    
    #region Private

    /// <summary>
    /// Sets the pay pal pro configuration properties.
    /// </summary>
    private void SetPayPalProConfigurationProperties() {
      ltDescription.Text = HttpUtility.HtmlDecode(base.Provider.Description);
      pnlSettings.GroupingText = LocalizationUtility.GetText("pnlPayPalProConfiguration");
      lblDescriptionTitle.Text = LocalizationUtility.GetText("lblPayPalProDescriptionTitle");
    }
    
    #endregion
    
    #endregion
    
  }
}