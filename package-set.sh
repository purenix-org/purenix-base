python success.py | jq 'to_entries | map(select(.value.success==true)) | map({key: .key, value: .value.derivation.version}) | from_entries'
