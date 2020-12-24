module ApplicationHelper

  module SessionConstants
    SELECTED_MENU_ITEM = :selected_menu_item
    USER_ID = :user_id
  end

  def get_index_text(value)
    "<div class=\"row\">
  <div class=\"col-sm-12\" style=\"padding-left: 0px;\">
  <div class=\"head_style\">" "#{value}</div></div></div>".html_safe
  end


  def cc_avenue_details(payment_details, return_url)
    values = {
        :order_id => payment_details.tnr_no,
        :amount => payment_details.amount,
        :currency => 'INR',
        :merchant_id => '195866',
        :redirect_url => return_url,
        :cancel_url => return_url,
        :language => 'EN',
        :billing_name => payment_details.name,
        :billing_address => "",
        :billing_city => "",
        :billing_zip => "",
        :billing_tel => payment_details.mobile_number,
        :billing_email => payment_details.email,
        :billing_state => "",
        :billing_country => 'India'
    }
    #"http://localhost:3000/cc_avenue/ccavRequestHandler?" + values.to_query
    "https://testboatingcontrolroom.aptdc.in/cc_avenue/ccavRequestHandler?" + values.to_query
    ##"http://java.meritcampus.com/cc_avenue/ccavRequestHandler?" + values.to_query
  end



  def self.get_root_url
    #"http://13.126.227.150/"
    "http://localhost:3000/"

    # "https://testboatingcontrolroom.aptdc.in/"
  end

end