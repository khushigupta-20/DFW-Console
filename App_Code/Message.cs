using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;

/// <summary>
/// Summary description for Message
/// </summary>
public class Message
{
    public static void WarningMessage(Control page, string msg)
    {
        ScriptManager.RegisterClientScriptBlock(page, page.GetType(), "alertMessage", "swal({ title: 'Warning', text: '" + msg + "', icon: 'warning', dangerMode: true, })", true);

    }
    public static void SuccessMessess(Control page, string msg)
    {
        string myScript = String.Format("swal('Success', '{0}', 'success')", msg);
        ScriptManager.RegisterClientScriptBlock(page, page.GetType(), "alertMessage", myScript, true);
    }
    public static void WarningAlert(Control page, string msg)
    {
        ScriptManager.RegisterClientScriptBlock(page, page.GetType(), "alertMessage", "toastr['warning']('" + msg + "', 'Warning');", true);

    }
    public static void SuccessAlert(Control page, string msg)
    {
        string myScript = String.Format("toastr['success']('{0}', 'Success');", msg);
        ScriptManager.RegisterClientScriptBlock(page, page.GetType(), "alertMessage", myScript, true);
    }

    public static void ShowSweetAlert(Control page, string msg)
    {
        string myScript = String.Format("swal('Success', '{0}', 'success')", msg);
        ScriptManager.RegisterClientScriptBlock(page, page.GetType(), "alertMessage", myScript, true);
    }

  
}