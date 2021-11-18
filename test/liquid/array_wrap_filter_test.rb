# frozen_string_literal: true

require 'test_helper'
require 'pry'

class ArraywrapTest < ActiveSupport::TestCase
  test 'wraps an object in with an array if it is not already an array' do
    template_data = "{%assign res = payload.test['DAHUA_MSG']['ITEM_DATA'] | array_wrap %}{%for item in res%}{{item['PN']['$']}}{%endfor%}"
    
    result = Liquor.render(template_data, assigns: { 'payload' => { 'test' => 
    {
      "DAHUA_MSG"=> {
        "ITEM_DATA"=> {
          "PN"=> {
            "$"=> "1.0.03.04.10264"
          },
          "UOM"=> {
            "$"=> "PCS"
          },
          "MODEL"=> {
            "$"=> "IPC-K22AP"
          },
          "SENDER"=> {
            "$"=> "DH292"
          },
          "PCS_BOX"=> {
            "$"=> "20"
          },
          "DOC_DATE"=> {
            "$"=> "20211118162922"
          },
          "EAN_CODE"=> {
            "$"=> "6939554982828"
          },
          "MAC_FLAG"=> {
            "$"=> "Y"
          },
          "RECEIVER"=> {
            "$"=> "RAPID"
          },
          "CASE_WIDTH"=> {
            "$"=> "376"
          },
          "SERIALIZED"=> {
            "$"=> "Y"
          },
          "WEIGHT_UOM"=> {
            "$"=> "KG"
          },
          "CASE_HEIGHT"=> {
            "$"=> "233"
          },
          "CASE_LENGTH"=> {
            "$"=> "486"
          },
          "DESCRIPTION"=> {
            "$"=> "CONSUMER CAMERA"
          },
          "UNIT_WEIGHT"=> {
            "$"=> "0"
          },
          "DIMENSION_UOM"=> {
            "$"=> "MM"
          },
          "OPERATION_TYPE"=> {
            "$"=> "ADD"
          },
          "ORGANIZATION_CODE"=> {
            "$"=> "292"
          }
        }
      }
      }
    } })
    assert_equal '1.0.03.04.10264', result
  end
end
