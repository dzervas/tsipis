#!/usr/bin/python

ANSIBLE_METADATA = {
    "metadata_version": "1.0",
    "status": ["stableinterface"],
    "supported_by": "community"
}

DOCUMENTATION = """
---
module: gopass_import

short_description: Import variables from a gopass secret

version_added: "2.4"

description:
    - "Import ansible variables from a gopass secret - should contain YAML"

options:
    name:
        description:
            - Name of secret to import
        required: true

author:
    - Dimitris Zervas (@dzervas)
"""

EXAMPLES = """
# Import ansible/example/secret
- name: Test with a message
  gopass_import:
    name: ansible/example/secret

# Import mount/test/hello
- name: Test with a message and changed output
  gopass_import: mount/test/hello
"""

RETURN = """
original_message:
    description: The original name param that was passed in
    type: str
    returned: always
message:
    description: The output message that the test module generates
    type: str
    returned: always
"""

from ansible.module_utils.basic import AnsibleModule

def run_module():
    # define available arguments/parameters a user can pass to the module
    module_args = dict(
        name=dict(type="str", required=True),
    )

    result = dict(
        changed=False,
        original_message="",
        message=""
    )

    module = AnsibleModule(
        argument_spec=module_args,
        supports_check_mode=True
    )


    result["original_message"] = module.params["name"]
    result["message"] = "goodbye"

    # use whatever logic you need to determine whether or not this module
    # made any modifications to your target
    if module.params["new"]:
        result["changed"] = True

    # during the execution of the module, if there is an exception or a
    # conditional state that effectively causes a failure, run
    # AnsibleModule.fail_json() to pass in the message and the result
    if module.params["name"] == "fail me":
        module.fail_json(msg="You requested this to fail", **result)

    # in the event of a successful module execution, you will want to
    # simple AnsibleModule.exit_json(), passing the key/value results
    module.exit_json(**result)

def main():
    run_module()

if __name__ == "__main__":
    main()


