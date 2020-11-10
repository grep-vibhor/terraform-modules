# Enable services in GCP project

### Input Parameters

Parameter                 |  type           | required | default value   |   
:-----------------        | :---            | :--------: | :--------------- |
project_id                |   string        | Required | N/A             |
service_name_list         |   list(string)  | Required | N/A             |
disable_dependent_services|   bool          | Optional | false           |
disable_on_destroy        |   bool          | Optional | false           |

### Output Parameters
Parameter                 |  type           |   
:-----------------        | :---            |
service_name_list         |   list(string)  |
