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

namespace MettleSystems.dashCommerce.Store.Services.TaxService {
  public interface ITaxProvider {

    /// <summary>
    /// Gets or sets a value indicating whether this instance is product level tax provider.
    /// </summary>
    /// <value>
    /// 	<c>true</c> if this instance is product level tax provider; otherwise, <c>false</c>.
    /// </value>
    bool IsProductLevelTaxProvider {
      get; 
    }

    /// <summary>
    /// Gets the tax rate.
    /// </summary>
    /// <param name="product">The product.</param>
    /// <returns></returns>
    decimal GetTaxRate(Product product);

    /// <summary>
    /// Gets the tax rate.
    /// </summary>
    /// <returns></returns>
    void GetTaxRate(Order order);
    
  }
}