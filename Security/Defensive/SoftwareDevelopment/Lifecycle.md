# Software Development Lifecycle

## Risk Assesment
Used to determine the level of potential thereat. 

1. Assume the software will be attacked. 

    List out factors such as:
    - data value of the program
    - security level of companies who provide infrastructure (MS, AWS, Google)
    - clients purchasing the software
    - scope of release (global, local)

    Example:
    Lets say a company hasn't complied with GDPR. If left and the company has been compromised it could cost them millions. To address the issue right away it would cost 40,000. A risk assessment will help the company and stakeholders understand this risk.

2. Risk evaluation

    What is the worst case scenario?
    - determine value of data stolen
    - users affected
    - demonstrate attack

3. Denial of service / availability

    What happens if the application goes offline?
    - authentication
    - rate limiting
    - availability impact

### Types of Risk Assessment

1. Qualitative
The goal is to assess and classify risk into thresholds (low, medium, high)
```sh
Risk = Severity * Likelihood
```

2. Quantitative
Measures risk in numerical values.

5x5 Risk Matrix
[Risk Matrix](Images/risk-matrix)


