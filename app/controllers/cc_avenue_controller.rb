class CcAvenueController < ApplicationController

  #skip_before_filter :authorize
  include CcAvenueHelper
  def dataFrom
  end

  def ccavRequestHandler
    merchantData=""
    working_key="11CDD88FA9300161D312393FE8CC21E8"    #Put in the 32 Bit Working Key provided by CCAVENUES.
    @access_code="AVRJ81FJ32CJ82JRJC"    #Put in the Access Code in quotes provided by CCAVENUES.

    #working_key="C5AAC79A4525AB6D4B0FAB6C40A07863"    #Put in the 32 Bit Working Key provided by CCAVENUES.
    #@access_code="AVMI02BJ92CF36IMFC"    #Put in the Access Code in quotes provided by CCAVENUES.
    params.each do |key,value|
      merchantData += key+"="+value+"&"
    end

    puts merchantData

    @encrypted_data = encrypt(merchantData,working_key)

  end

  def ccavResponseHandler
  end

end