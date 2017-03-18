RSpec.configure do |config|
  config.before(:each) do
    stub_request(:post, /https:\/\/sandbox.public.api.bunq.com\/v1\/user\/.*monetary-account-bank/)
      .to_return(status: 200, body: {
        "Response": [
        {
        "MonetaryAccountBank": {
        "id": 42,
        "created": "2015-06-13 23:19:16.215235",
        "updated": "2015-06-30 09:12:31.981573",
        "avatar": {
        "uuid": "5a442bed-3d43-4a85-b532-dbb251052f4a",
        "anchor_uuid": "f0de919f-8c36-46ee-acb7-ea9c35c1b231",
        "image": [
        {
        "attachment_public_uuid": "d93e07e3-d420-45e5-8684-fc0c09a63686",
        "content_type": "image/jpeg",
        "height": 380,
        "width": 520
        }
        ]
        },
        "currency": "EUR",
        "description": "Mary's savings",
        "daily_limit": {
        "value": "12.50",
        "currency": "EUR"
        },
        "daily_spent": {
        "value": "12.50",
        "currency": "EUR"
        },
        "overdraft_limit": {
        "value": "12.50",
        "currency": "EUR"
        },
        "balance": {
        "value": "12.50",
        "currency": "EUR"
        },
        "alias": [
        {
        "type": "EMAIL",
        "value": "bravo@bunq.com",
        "name": ""
        }
        ],
        "public_uuid": "252e-fb1e-04b74214-b9e9467c3-c6d2fbf",
        "status": "CANCELLED",
        "sub_status": "PERMANENT",
        "reason": "OTHER",
        "reason_description": "I am done saving.",
        "user_id": 1,
        "monetary_account_profile": {
        "profile_fill": {
        "status": "ACTIVE",
        "balance_preferred": {
        "value": "12.50",
        "currency": "EUR"
        },
        "balance_threshold_low": {
        "value": "12.50",
        "currency": "EUR"
        },
        "method_fill": "IDEAL",
        "issuer": {
        "bic": "INGBNL2A",
        "name": "ING Bank"
        }
        },
        "profile_drain": {
        "status": "ACTIVE",
        "balance_preferred": {
        "value": "12.50",
        "currency": "EUR"
        },
        "balance_threshold_high": {
        "value": "12.50",
        "currency": "EUR"
        },
        "savings_account_alias": {
        "iban": "NL12BUNQ0300065264",
        "display_name": "Mary",
        "avatar": {
        "uuid": "5a442bed-3d43-4a85-b532-dbb251052f4a",
        "anchor_uuid": "f0de919f-8c36-46ee-acb7-ea9c35c1b231",
        "image": [
        {
        "attachment_public_uuid": "d93e07e3-d420-45e5-8684-fc0c09a63686",
        "content_type": "image/jpeg",
        "height": 380,
        "width": 520
        }
        ]
        },
        "label_user": {
        "uuid": "252e-fb1e-04b74214-b9e9467c3-c6d2fbf",
        "avatar": {
        "uuid": "5a442bed-3d43-4a85-b532-dbb251052f4a",
        "anchor_uuid": "f0de919f-8c36-46ee-acb7-ea9c35c1b231",
        "image": [
        {
        "attachment_public_uuid": "d93e07e3-d420-45e5-8684-fc0c09a63686",
        "content_type": "image/jpeg",
        "height": 380,
        "width": 520
        }
        ]
        },
        "public_nick_name": "Mary",
        "display_name": "Mary",
        "country": "NL"
        },
        "country": "NL",
        "bunq_me": {
        "type": "EMAIL",
        "value": "bravo@bunq.com",
        "name": ""
        }
        }
        }
        },
        "notification_filters": [
        {
        "notification_delivery_method": "URL",
        "notification_target": "https://my.company.com/callback-url",
        "category": "PAYMENT"
        }
        ],
        "setting": {
        "color": "#FF0024",
        "default_avatar_status": "AVATAR_DEFAULT",
        "restriction_chat": "ALLOW_INCOMING"
        }
        }
        }
        ]
      }.to_json, headers: {})
  end
end
