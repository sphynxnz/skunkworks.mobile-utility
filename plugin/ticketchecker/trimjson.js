/**
 * @const traverse
 * Traverse and transform objects by visiting every node in a recursive walk
 */
const traverse = require('traverse')

/**
 * @function anonymous - traverses each node of the JSON object and trims each leaf node
 *                       if it is of type string and length is greater than 0
 * @param {Object} json - a JSON object
 */
module.exports = (json) => {
  traverse(json).forEach(function (node) {
    if (this.isLeaf && typeof node === 'string' && node.length > 0) {
      this.update(node.trim(), true)
    }
  })
  return (json)
}
