CLASS zcl_rsh_products_uq DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_rap_query_provider .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_rsh_products_uq IMPLEMENTATION.


  METHOD if_rap_query_provider~select.

    DATA:
      lt_business_data    TYPE TABLE OF zzrshsepmra_i_product_e,
      lo_http_client      TYPE REF TO if_web_http_client,
      lo_client_proxy     TYPE REF TO /iwbep/if_cp_client_proxy,
      lo_request          TYPE REF TO /iwbep/if_cp_request_read_list,
      lo_response         TYPE REF TO /iwbep/if_cp_response_read_lst,
      lo_filter_node_root TYPE REF TO /iwbep/if_cp_filter_node.


    TRY.
        " Create http client
        DATA(lo_destination) = cl_http_destination_provider=>create_by_url(
                i_url = 'https://sapes5.sapdevcenter.com' ).

        lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination
          ).

        lo_client_proxy = cl_web_odata_client_factory=>create_v2_remote_proxy(
          EXPORTING
            iv_service_definition_name = 'ZRISHI_PRODUCTS'
            io_http_client             = lo_http_client
            iv_relative_service_root   = '/sap/opu/odata/sap/ZPDCDS_SRV/' ).

        " Navigate to the resource and create a request for the read operation
        lo_request = lo_client_proxy->create_resource_for_entity_set( 'SEPMRA_I_PRODUCT_E' )->create_request_for_read( ).

        "Get filter
        DATA(lt_product_range) = io_request->get_filter(  )->get_as_ranges(  ).
        " Create the filter tree
        DATA(lo_filter_factory) = lo_request->create_filter_factory( ).

        LOOP AT lt_product_range ASSIGNING FIELD-SYMBOL(<lfs_cond>).
          DATA(lo_filter_node) = lo_filter_factory->create_by_range( iv_property_path = <lfs_cond>-name
                                                               it_range         = <lfs_cond>-range ).
          IF lo_filter_node_root IS INITIAL.
            lo_filter_node_root = lo_filter_node.
          ELSE.
            lo_filter_node_root = lo_filter_node_root->and( lo_filter_node ).
          ENDIF.
        ENDLOOP.

        "Set filter on Business Data.
        lo_request->set_filter(
          EXPORTING
            io_filter_node = lo_filter_node_root
        ).

        "pagination information from Query.
        io_request->get_paging(
          RECEIVING
            ro_paging = DATA(lo_paging)
        ).

        DATA(lv_top) =  lo_paging->get_page_size( ).
        DATA(lv_skip)  =  lo_paging->get_offset( ) .

        "Pagination on Business Data.
        lo_request->set_top( CONV #( lv_top ) )->set_skip( CONV #( lv_skip ) ).


        " Execute the request and retrieve the business data
        lo_response = lo_request->execute( ).


**        CATCH /iwbep/cx_gateway.

        lo_response->get_business_data( IMPORTING
                                            et_business_data = lt_business_data
                                             ).

      CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
        DATA(lv_remote_error) = lx_remote->get_text(  ).
      CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).

        DATA(lv_text) = lx_gateway->get_longtext(  ).

    ENDTRY.


    io_response->set_data( lt_business_data ).
    io_response->set_total_number_of_records(  lines( lt_business_data ) ).


  ENDMETHOD.
ENDCLASS.
