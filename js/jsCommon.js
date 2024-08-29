
function isValidEmailAddress(emailAddress) {
    var pattern = new RegExp(/^[+a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/i);
    //var emailPat = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;

    return pattern.test(emailAddress);
}

// ==========================> For Enter to Focus 
function controlEnter(obj, event, ischosen) {
    var keyCode = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;
    if (keyCode == 13) {
        if (ischosen) {
            setTimeout(function () {
                $('#' + obj).trigger("liszt:open");
            }, 100);
        }
        else {
            $('#' + obj).focus().select();
        }

        return false;
    }
    else {
        return true;
    }
}

// ==========================> Set Focus to Object when Drop Down List Change
function fncDropDownChange(obj, ischosen) {
    try {

        if (ischosen) {
            setTimeout(function () {
                $('#' + obj).trigger("liszt:open");
            }, 50);
        }
        else {
            setTimeout(function () {
                $('#' + obj).focus().select();
            }, 50);

        }

    }
    catch (err) {
        ShowToastError(err.message);
    }

}

//===================> alphabet key enter false without allow Decimal
function isNumberKey(event) {

    var charCode = (event.which) ? event.which : event.keyCode;
    if (charCode > 31 && (charCode < 48 || charCode > 57) && !(charCode >= 96 && charCode <= 105)) {
        event.preventDefault();
        return false;
    }
    return true;


}

//===================> alphabet key enter false with allow Decimal 

function isNumberKeyWithDecimal(evt) {
    try {
      
        var charCode = (evt.which) ? evt.which : evt.keyCode;
        
        if (charCode > 95 && charCode < 106) {
            return true;
            evt.preventDefault();
        }
        else if ((charCode != 46 && charCode > 31)
        && (charCode < 48 || charCode > 57) && charCode != 110) {  
            return false;
            evt.preventDefault();
        }

        return true;
    }
    catch (err) {
        ShowPopupMessageBox(err.message);
    }
}

//================================== Clear All Form Fields ==================================//
function clearFormCommon() {
    $(':input').not(':button, :submit, :reset, :hidden, :checkbox, :radio').val('');
    $(':checkbox, :radio').prop('checked', false);

    $("select").val(0);
    $("select").trigger("liszt:updated");
}

//===================> alphabet key enter false with allow Minize Symbol
function isNumberKeywithMin(evt) {
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (charCode != 45 && charCode != 46 && charCode > 31
            && (charCode < 48 || charCode > 57))
        return false;

    return true;
}

function fncSetFocustoObject(obj) {
    try {
        setTimeout(function () {
            obj.focus().select();
        }, 50);
        AfterPopupSetFocusToControl = "";
    }
    catch (err) {
        ShowToastError(err.message);
    }
}

function fncOpenDropdownlist(obj) {
    try {
        setTimeout(function () {
            obj.trigger("liszt:open");
        }, 50);
        AfterPopupSetFocusToControl = "";
    }
    catch (err) {
        ShowToastError(err.message);
    }
}

function fncConvertFloatJS(value) {
    try {
        if (parseFloat(value) == NaN || value == "") {
            return 0;
        }
        else {
            return value;
        }
    }
    catch (err) {
        ShowToastError(err.message);
    }
}

//===================> Enter Focus not Fire
function controlEnterNotFire(obj, event) {
    var keyCode = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;
    if (keyCode == 13) {
        return false;
    }
    else {
        return true;
    }
}

