Promise = require("bluebird");
XeroConnection = require('./xero-connection');

module.exports = {
  doRequest: () ->
    promise = new Promise (resolve, reject) ->
      # https://api.xero.com/api.xro/2.0/reports/BankSummary
      XeroConnection().call 'GET', 'reports/BankSummary', null, (err, json) ->
        if(err)
          reject
        else
          resolve(json)

    return promise;

  parseResponse: (jsonResponse) ->
    # Filter and map to array of array
    cellRows = jsonResponse.Reports[0].Rows.filter((row) -> row.RowType == "Section" && row.Rows[0].RowType == "Row").map((row) -> row.Rows[0].Cells)
    if (cellRows.length > 0)
      cellRows.map( (cellRow) ->
        {
          #First cell's Value
          accountName: cellRow[0].Value
          # Last cell
          closingBalance: cellRow.slice(-1)[0].Value
        }
      )

  formatAnswer: (answer) ->
    formattedAnswer = "\n"
    answer.forEach((row) -> formattedAnswer = formattedAnswer + "#{row.accountName}: #{row.closingBalance}\n")
    formattedAnswer

}
