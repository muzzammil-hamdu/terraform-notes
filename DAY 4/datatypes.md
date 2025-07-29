Certainly! Here are **detailed notes on ALL major Terraform variable data types**—including syntax, rules, examples, best practices, and common usage patterns.

# 🌟 Terraform Variable Data Types: Detailed Notes

Terraform variables must be given a **datatype** to specify what kind of value they can hold. Defining the correct type helps prevent errors and makes your configuration robust and portable.

## 1. Primitive Data Types

These are the basic building blocks. They store values like text, numbers, or booleans.

### 1.1 **string**
- **Definition**: Any sequence of characters (letters, numbers, symbols), always in double quotes (`" "`).
- **Multi-line**: Use `\n` for new lines.
- **Syntax:**
  ```hcl
  variable "example_str" {
    type    = string
    default = "test123"
  }
  variable "multiline_str" {
    default = "test123\nshgf"
  }
  ```
- **Use Cases**: Names, descriptions, IDs.

### 1.2 **number**
- **Definition**: Any integer or decimal.
- **Syntax:**
  ```hcl
  variable "an_int" {
    type    = number
    default = 125
  }
  variable "a_float" {
    default = 10.5
  }
  ```
- **Use Cases**: Port numbers, instance counts, fees/rates, resource sizes.

### 1.3 **bool** (boolean)
- **Definition**: Logical true/false.
- **Syntax:**
  ```hcl
  variable "is_active" {
    type    = bool
    default = true
  }
  ```
- **Use Cases**: Conditional resource creation, feature toggles.

### 1.4 **any**
- **Definition**: Flexible type that allows **anything** (string, number, bool, list, map, object, etc.).
- **Syntax:**
  ```hcl
  variable "anything_goes" {
    type    = any
    default = 10
  }
  ```
- **Use Cases**: When the type might change or is unknown/variable.

## 2. Complex (Composite) Data Types

Used to model relationships, structures, and collections of data.

### 2.1 **list**
- **Definition**: Ordered sequence of values, usually of the same type.
- **Syntax & Example:**
  ```hcl
  # A list of mixed types (acceptable with type=any)
  variable "mixed_list" {
    type    = list(any)
    default = ["test", 123, true, "test", 123]
  }

  # Enforcing a list of numbers
  variable "number_list" {
    type    = list(number)
    default = [1, 2, 3, 4, 5, 2, 4, 7, 1, 2]
  }

  # Nested list (matrix)
  variable "matrix" {
    type    = list(list(number))
    default = [[1,2],[3,4],[5,6]]
  }
  ```
- **Access**: Via zero-based index.
  ```hcl
  var.number_list[2] # => 3
  ```
- **Inject via tfvars:**
  ```hcl
  number_list = [1,2,5,6.7]
  ```

- **Warning**: Accessing out of range will cause an error.
  ```hcl
  default = [1,2]
  var.varname[2]    # Error!
  ```

### 2.2 **set**
- **Definition**: Unordered collection of unique values (duplicates eliminated).
- **Syntax & Example:**
  ```hcl
  variable "unique_numbers" {
    type    = set(number)
    default = [1,2,3,4,5,2,4,7,1,2] # will be {1,2,3,4,5,7}
  }
  ```
- **Notes:**
  - Order is **not** preserved (unlike list).
  - Access by index is **not guaranteed**!!
- **Use Case**: When uniqueness is required, but order is not important.

### 2.3 **map**
- **Definition**: Unordered set of key-value pairs.
- **Keys**: Must be **strings**; **values** can be any type (or specified).
- **Syntax & Example:**
  ```hcl
  variable "plain_map" {
    type = map(any)
    default = {
      name     = "mujju"
      id       = 123
      isactive = true
    }
  }

  variable "string_map" {
    type = map(string)
    default = {
      name     = "mujju"
      id       = "123"
      isactive = "yes"
    }
  }

  variable "number_map" {
    type = map(number)
    default = {
      id    = 12345
      phone = 43154431
    }
  }
  ```
- **Map of lists**:
  ```hcl
  variable "map_list_string" {
    type = map(list(string))
    default = {
      id      = ["12", "34"]
      address = ["A", "B"]
    }
  }
  ```
- **Access**:
  ```hcl
  var.plain_map["name"]
  var.plain_map.id
  ```
- **Error**: Accessing a nonexistent key (e.g., `var.plain_map.phoneno`) triggers an error.
- **Inject via tfvars:**
  ```hcl
  plain_map = { name = "test", dob = 123 }
  ```

### 2.4 **tuple**
- **Definition**: Fixed-length, order-specific sequence—**each position can have a different type**.
- **Syntax & Example:**
  ```hcl
  variable "mytuple" {
    type = tuple([string, number, bool, list(number)])
    default = ["mujju", 123, true, [1,2,3]]
  }
  ```
- **Order matters!**
  - `[string, number, ...]` is **not** the same as `[number, string, ...]`
- **Errors**:
  ```hcl
  default = ["mujju", 123"]                 # Missing bool/list
  default = ["mujju", 123, [1, 2, 3], true] # Wrong order or type
  ```
- **Access**:
  ```hcl
  var.mytuple[0]     # "mujju"
  var.mytuple[3][1]  # 2 (second element in the list)
  ```

### 2.5 **object**
- **Definition**: Custom user-defined structure with named fields (**like a struct**).
- **Syntax & Example:**
  ```hcl
  variable "person" {
    type = object({
      name    = string
      id      = number
      address = list(string)
    })
    default = {
      name    = "mujju"
      id      = 123
      address = ["marathalli", "bangalore", "560037"]
    }
  }
  ```
- **Must** match declared keys and types.
- **Access**:
  ```hcl
  var.person.name
  var.person.address[2]   # "560037"
  ```

## 3. Syntax Reference Table

| Type          | Declaration Example                      | Access Example         | Notes                                 |
|---------------|-----------------------------------------|-----------------------|---------------------------------------|
| string        | `type = string`                         | `var.foo`             | Text in double quotes                 |
| number        | `type = number`                         | `var.num`             | Integer or float                      |
| bool          | `type = bool`                           | `var.flag`            | true/false unquoted                   |
| any           | `type = any`                            | `var.flex`            | Accepts any type                      |
| list(type)    | `type = list(number)`                   | `var.list`         | Indexed, ordered                      |
| set(type)     | `type = set(string)`                    | -                     | Unique, order not preserved           |
| map(type)     | `type = map(string)`                    | `var.map["key"]`      | Lookup by key                         |
| tuple(types)  | `type = tuple([string, bool, number])`  | `var.tuple`        | Fixed type & order, indexed           |
| object({})    | see above                               | `var.obj.key`         | Structured map with type constraints  |

## 4. Best Practices & Notes

- **Always specify types** unless there's a strong reason not to (`any`).
- **Use lists or sets** for collections — pick list if order matters, set if uniqueness matters.
- **Use map/object** for key-value and structured data—use object for enforcement, map for looser key structure.
- **Tuple** is best for values where you expect "different fields by position" (like a function argument list).
- **Avoid `any`** for critical infra — it's less safe, harder to validate.

## 5. Injection and Access Patterns

- **Inject** values via `terraform.tfvars`, CLI `-var`, or environment.
  ```tfvars
  name = "test"
  number_list = [1,2,3,4]
  person = { name = "mujju", id = 20, address = ["abc"] }
  ```
- **Access** in configuration:
  - Variable: `var.varname`
  - List: `var.ls[index]`
  - Map/object: `var.map["key"]` or `var.object.key`
  - Tuple: `var.tuple[i]` or nested (e.g., `var.tuple`)

## 6. Quick Examples

```hcl
variable "flag"    { type = bool;   default = true }
variable "count"   { type = number; default = 3 }
variable "cities"  { type = list(string); default = ["blr", "del", "hyd"] }
variable "phones"  { type = set(number); default = [123,456,123] }
variable "tags"    { type = map(string); default = {env = "prod", owner="ops"} }
variable "server"  {
  type = object({
    hostname = string
    port     = number
    ssl      = bool
  })
  default = {
    hostname = "srv"
    port     = 443
    ssl      = true
  }
}
variable "creds" {
  type = tuple([string, number, bool])
  default = ["user", 42, false]
}
```

## 7. Error Scenarios

- **Wrong type**:
  ```hcl
  type = number
  default = "text"    # ERROR!
  ```
- **List index out of bounds**:
  ```hcl
  default = [1,2]
  var.varname[2]      # ERROR!
  ```
- **Map key missing**:
  ```hcl
  default = { name = "x" }
  var.varname["id"]   # ERROR!
  ```

## 8. At a Glance: Choosing Types

| Scenario                    | Type    | Example                                    |
|-----------------------------|---------|--------------------------------------------|
| A name or label             | string  | `"project-01"`                             |
| A count or size             | number  | `5` or `4.7`                               |
| On/off toggle               | bool    | `true`                                     |
| List of similar values      | list    | `["a", "b", "c"]`                          |
| Unique set of IDs           | set     | ``                                  |
| Mapping from names to vals  | map     | `{ foo = "bar", spam="eggs" }`             |
| Record with fixed fields    | object  | `{ id=42, tags=["one","two"] }`            |
| Ordered, mixed-type config  | tuple   | `["msg", 1, false]`                        |
