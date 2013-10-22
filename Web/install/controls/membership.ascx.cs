#region dashCommerce License
/*
dashCommerce® is Copyright © 2008-2012 Mettle Systems LLC. All Rights Reserved.


dashCommerce, and the dashCommerce logo are registered trademarks of Mettle Systems LLC. Mettle Systems LLC logos and trademarks may not be used without prior written consent.

dashCommerce is licensed under the following license. If you do not accept the terms, please discontinue the use of dashCommerce and uninstall dashCommerce. 

Your license to the dashCommerce source and/or binaries is governed by the Reciprocal Public License 1.5 (RPL1.5) license as described here: 

http://www.opensource.org/licenses/rpl1.5.txt 

If you do not wish to release the source of software you build using dashCommerce, you may purchase a site license, which will allow you to deploy dashCommerce for use in 1 web store defined as using 1 URL. You may purchase a site license here: 

http://www.dashcommerce.org/license.html 
*/
#endregion
using System;
using System.Web.Security;
using System.Web.UI;



namespace MettleSystems.dashCommerce.Web.install.controls {
  public partial class membership : InstallControl {

    #region Page Events

    /// <summary>
    /// Handles the Load event of the Page control.
    /// </summary>
    /// <param name="sender">The source of the event.</param>
    /// <param name="e">The <see cref="T:System.EventArgs"/> instance containing the event data.</param>
    protected override void Page_Load(object sender, EventArgs e) {
      try {
        base.Page_Load(sender, e);
        Page.Form.DefaultButton = btnNext.UniqueID;
      }
      catch (Exception ex) {
        MasterPage.MessageCenter.DisplayCriticalMessage(ex.Message);
      }
    }

    /// <summary>
    /// Handles the Click event of the btnNext control.
    /// </summary>
    /// <param name="sender">The source of the event.</param>
    /// <param name="e">The <see cref="T:System.EventArgs"/> instance containing the event data.</param>
    protected override void btnNext_Click(object sender, EventArgs e) {
      try {
        MembershipCreateStatus status = MembershipCreateStatus.UserRejected;
        Membership.CreateUser(txtUsername.Text.Trim(), txtPassword.Text.Trim(), txtEmail.Text.Trim(), txtSecurityQuestion.Text.Trim(), txtSecurityAnswer.Text.Trim(), true, out status);
        if(status == MembershipCreateStatus.Success) {
          Roles.AddUserToRole(txtUsername.Text.Trim(), "Administrator");
        }
        base.btnNext_Click(sender, e);        
      }
      catch(Exception ex) {
        MasterPage.MessageCenter.DisplayCriticalMessage(ex.Message);
      }
    }


    #endregion

  }
}