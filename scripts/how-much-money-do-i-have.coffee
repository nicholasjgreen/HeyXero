Promise = require("bluebird");
XeroConnection = require('./xero-connection');
numeral = require('numeral');

module.exports = {

  doRequest: () ->
    new Promise((resolve, reject) ->
      # https://api.xero.com/api.xro/2.0/reports/BankSummary
      XeroConnection().call 'GET', '/reports/BankSummary', null, (err, json) ->
        if(err)
          reject()
        else
          resolve(json)
    )

  parseResponse: (jsonResponse) ->

    console.log("Received: #{JSON.stringify(jsonResponse)}")

    # Filter and map to array of array
    cellRows = jsonResponse.Response.Reports.Report.Rows.Row.filter((row) -> row.RowType == "Section" && row.Rows.Row[0].RowType == "Row").map((row) -> row.Rows.Row[0].Cells.Cell)
    if (cellRows.length > 0)
      cellRows.map( (cellRow) ->
        {
          # First cell's Value
          accountName: cellRow[0].Value
          # Last cell
          closingBalance: cellRow.slice(-1)[0].Value
        }
      )

  formatAnswer: (answer) ->
    formattedAnswer = "\n"
    answer.forEach((row) -> formattedAnswer = formattedAnswer + "#{row.accountName}: #{numeral(row.closingBalance).format('$0,0.00')}\n")
    formattedAnswer

}
